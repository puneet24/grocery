class CartsController < ApplicationController
	def index
		@carts = Cart.find_by_sql("select *from carts where user_id = #{current_user.id}")
	end

	def add
		cart = Cart.where('user_id=? and product_id=?',current_user.id,params[:id]).first
		if cart.nil?
			cart = Cart.new
			cart.user_id = current_user.id
			cart.product_id = params[:id].to_i
			cart.quantity = 1
			cart.save
		else
			cart.quantity += 1
			cart.save
		end
		redirect_to action: 'index'
	end

	def delete
		Cart.delete(Cart.where('user_id = ? and product_id = ?',current_user.id,params[:id]).first.id)
		redirect_to action: 'index'
	end

	def placeorder
		puts current_user.id
		order = Order.new
		order.user_id = current_user.id
		order.save!
		carts = Cart.find_by_sql("select *from carts where user_id = #{current_user.id}")
		carts.each do |cart|
			orderitem = Orderitem.new
			orderitem.user_id = cart.user_id
			orderitem.quantity = cart.quantity
			orderitem.product_id = cart.product_id
			orderitem.order_id = order.id
			orderitem.save!
		end
		Cart.destroy_all(user_id: current_user.id)
		redirect_to orders_view_path(:id => order.id)
	end
end
