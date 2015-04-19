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
end
