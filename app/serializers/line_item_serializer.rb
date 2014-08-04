class LineItemSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :id, :quantity

  has_one :product
  has_one :order, root: :cart
end