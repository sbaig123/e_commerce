class User < ApplicationRecord

	has_secure_password

	has_many :orders

	has_one :pending_order, -> { where(status: false)}, class_name: "Order"

	validates :first_name, presence: true

	validates :password, length: {minimum: 7, message: 'is short. Minimum 7 characters'}

	validates :email, uniqueness: true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create}

end
