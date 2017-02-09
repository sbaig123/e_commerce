class Order < ApplicationRecord

	has_many :order_items, dependent: :destroy

	belongs_to :customer, class_name: "User", foreign_key: "user_id"

end
