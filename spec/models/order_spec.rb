require 'rails_helper'

Rails.describe Order, type: :model do

	it 'has many order items' do
		o = Order.reflect_on_association(:order_items)
		expect(o.macro).to eq :has_many
	end

	it 'belongs to customer' do
		o = Order.reflect_on_association(:customer)
		expect(o.macro).to eq :belongs_to
	end

	it 'total is sum of all the order items' do
		order = create :order
		order_item = create :order_item, order: order
		order_item1 = create :order_item, order: order
		expect(order.total).to eq (order_item.total_price + order_item1.total_price)
	end

	it 'status false until paid' do
		
	end

end
