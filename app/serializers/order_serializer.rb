class OrderSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :id

  has_many :line_items
end