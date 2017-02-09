class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
			t.belongs_to :order
			t.belongs_to :product
			t.integer :quantity
			t.float :unit_price
			t.float :total_price
      t.timestamps
    end
  end
end
