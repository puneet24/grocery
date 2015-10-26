class CreateOrderitems < ActiveRecord::Migration
  def change
    create_table :orderitems do |t|
    	t.integer :user_id
      t.integer :product_id
      t.integer :quantity
      t.integer :order_id
      t.timestamps
    end
  end
end
