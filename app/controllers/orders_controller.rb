class OrdersController < ApplicationController
  def index
  	@orders = Order.where('user_id = ?',current_user.id).reverse
  end

  def view
  	@order = Order.where('user_id = ? and id = ?',current_user.id,params[:id])
  	@order_id = params[:id]
  	@all_product_items = Orderitem.where('user_id = ? and order_id = ?',current_user.id,params[:id])
  end
end
