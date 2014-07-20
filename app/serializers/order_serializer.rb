class OrderSerializer < ActiveModel::Serializer
  attributes :id, :line_items

  def line_items
    []
  end
end