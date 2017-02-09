class OrderItem < ApplicationRecord
	
	belongs_to :product
  belongs_to :order

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
	validate :product_present
  validate :order_present

  before_save :finalize
	after_save :update_order
	after_destroy :update_order

	private

  def product_present
    if product.nil? || !product.status
      errors.add(:product, "is not valid or is not available.")
    end
  end

  def order_present
    if order.nil?
      errors.add(:order, "is not a valid order.")
    end
  end

  def finalize
    self[:unit_price] = product.price
    self[:total_price] = quantity * self[:unit_price]
  end

	def update_order
		order.total = 0
		order.order_items.all.each do |item|
			order.total = order.total + item.total_price
		end
		order.save
	end

end
