include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :shop do
    domain 'bookshop.com'
  end

  factory :product
  factory :cart
  factory :user do
    email 'test@email.com'
    password '123123123'
  end
end