class ProductSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :name, :description, :price, :img, :color, :fabric, :made_in
end