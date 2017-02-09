require 'rails_helper'

Rails.describe 'OrderItem', type: :model do

	describe 'validations:' do

		it 'quantity has to be present' do
			expect{ create :order_item, quantity: nil }.to raise_error(ActiveRecord::RecordInvalid).with_message(/Quantity can't be blank/)
		end

		it 'quantity has to be integer' do
			expect{ create :order_item, quantity: 1.4 }.to raise_error(ActiveRecord::RecordInvalid).with_message(/Quantity must be an integer/)
		end
		
		it 'not valid if order is not present' do
			expect{ create :order_item, order: nil }.to raise_error(ActiveRecord::RecordInvalid).with_message(/Order is not a valid order/)
		end

		it 'not valid if product is not available' do
			product = create :product, status: false
			expect{ create :order_item, product: product }.to raise_error(ActiveRecord::RecordInvalid).with_message(/Product is not valid or is not available/)
		end
	
		it 'not valid if product is not valid' do
			expect{ create :order_item, product: nil }.to raise_error(ActiveRecord::RecordInvalid).with_message(/Product is not valid or is not available/)
		end

		it 'before finalizing, unit and total price has to be included' do
			product = create :product
			order_item = create :order_item, product: product
			expect(order_item.unit_price).to eq product.price
			expect(order_item.total_price).to eq (product.price*order_item.quantity)
		end

	end

	describe 'associations' do
		it 'belongs to product' do
			oi = OrderItem.reflect_on_association(:product)
			expect(oi.macro).to eq :belongs_to
		end
		it 'belongs to order' do
			oi = OrderItem.reflect_on_association(:order)
			expect(oi.macro).to eq :belongs_to
		end 
	end

end
