class Shop
  include Mongoid::Document

  field :domain

  has_many :products
end