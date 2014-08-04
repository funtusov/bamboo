class LineItem
  include Mongoid::Document

  belongs_to :order
  belongs_to :product

  field :quantity, type: Integer, default: 1

  validates :quantity, presence: true, numericality: { greater_than: 0 }
end