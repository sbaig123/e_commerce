require 'rails_helper'

Rails.describe User, type: :model do

	describe 'validations' do

		it 'first_name is required' do
			expect{ create :user, first_name: "" }.to raise_error(ActiveRecord::RecordInvalid).with_message(/First name can't be blank/)
		end

		it 'email should be unique' do
			create :user, email: "example@gmail.com"
			expect{ create :user, email: "example@gmail.com" }.to raise_error(ActiveRecord::RecordInvalid).with_message(/Email has already been taken/)
		end

		it 'email should be in proper format' do
			expect{ create :user, email: "welcome@gma" }.to raise_error(ActiveRecord::RecordInvalid).with_message(/Email is invalid/)
		end
	
		it 'password and password confirmation has to be same' do
			expect{create :user, password: "1234567", password_confirmation: "1234568"}.to raise_error(ActiveRecord::RecordInvalid).with_message(/Password confirmation doesn't match Password/)
		end

		it 'password has to be minimum 7 words' do
			expect{create :user, password: "12345", password_confirmation: "12345"}.to raise_error(ActiveRecord::RecordInvalid).with_message(/Password is short. Minimum 7 characters/)
		end

		it 'by default is not admin' do
			user = create :user
			expect(user.admin).to_not be_truthy
		end

	end

	describe 'associations' do

		it 'has many orders' do 
			u = User.reflect_on_association(:orders)
		  expect(u.macro).to eq :has_many
		end

		it 'has one pending order' do
			u = User.reflect_on_association(:pending_order)
		  expect(u.macro).to eq :has_one
		end

	end

end
