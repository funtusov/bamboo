class Order
  include Mongoid::Document

  belongs_to :user
  has_many :line_items
end