include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :shop do
    domain 'bookshop.com'
  end

  factory :product
  factory :order
  factory :user do
    email 'test@email.com'
    password '123123123'
  end

  factory :line_item
end