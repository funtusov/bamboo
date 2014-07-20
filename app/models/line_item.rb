class LineItem
  include Mongoid::Document

  belongs_to :order
  belongs_to :product

  field :quantity, type: Integer, default: 0
end