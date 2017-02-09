require 'rails_helper'

RSpec.describe Product, :type => :model do

  it "name is mandatory" do
		expect{ create :product, name: "" }.to raise_error(ActiveRecord::RecordInvalid).with_message(/Name can't be blank/)
  end
	
	it "price should be in decimals" do
		expect{ create :product, price: "hello" }.to raise_error(ActiveRecord::RecordInvalid).with_message(/Price is not a number/)
	end

	it "by default product is available" do
		product = create :product
		expect(product.status).to be_truthy	
	end

end
