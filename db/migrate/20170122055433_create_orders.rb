class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
			t.string :order_no
			t.belongs_to :user
			t.float :total
			t.date :date
			t.boolean :status, default: false
    end
  end
end
