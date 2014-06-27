class Shop
  include Mongoid::Document

  field :domain

  has_many :products

  def self.current_id=(id)
    Thread.current[:tenant_id] = id
  end
  
  def self.current_id
    Thread.current[:tenant_id]
  end
end