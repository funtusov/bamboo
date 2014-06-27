class Product
  include Mongoid::Document

  belongs_to :shop
end