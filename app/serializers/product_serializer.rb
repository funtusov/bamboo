class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :img, :color, :fabric, :made_in
end