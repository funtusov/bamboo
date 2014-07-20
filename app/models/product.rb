class Product
  include Mongoid::Document

  default_scope -> { where(shop_id: Shop.current_id) }

  belongs_to :shop
  has_many :line_items

  field :name
  field :description
  field :price, type: Integer
  field :img
  field :color
  field :fabric
  field :made_in
end