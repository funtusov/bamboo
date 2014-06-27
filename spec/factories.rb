include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :shop do
    domain 'bookshop.com'
  end

  factory :product do
  end
end