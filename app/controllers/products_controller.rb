class ProductsController < ApplicationController
	def index
	end

	def add
		product = Product.new
		product.name = params[:name]
		product.price = params[:price]
		product.quantity = params[:quantity]
		product.desc = params[:desc]
		product.save
		redirect_to action: 'show'
	end

	def show
		if !current_user.nil? && current_user.email == "a@b.com" 
			@products = Product.all
		else
			@products = Product.find_by_sql("select *from products where quantity > 0")
		end
	end

	def view
		@product = Product.find(params[:id])
		if !current_user.nil? && current_user.email == "a@b.com"
			@disabled = false
		else
			@disabled = true
		end
	end

	def edit
		product = Product.find(params[:id])
		product.name = params[:name]
		product.price = params[:price]
		product.quantity = params[:quantity]
		product.desc = params[:desc]
		product.save
		redirect_to action: 'show'
	end
end
