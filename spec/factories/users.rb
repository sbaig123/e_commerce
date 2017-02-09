FactoryGirl.define do

	factory :user do
		first_name 'Joe'
		email 'example@gmail.com'
		password '1234567'
		password_confirmation '1234567'
	end

  factory :customer, class: User do
    first_name "John"
    email 'example@gmail.com'
		password '1234567'
		password_confirmation '1234567'
  end

  factory :admin, class: User do
    first_name "Admin"
    last_name  "User"
		password '1234567'
		password_confirmation '1234567'
    admin      true
  end

end
