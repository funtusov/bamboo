class Shop
  include Mongoid::Document

  field :domain

  has_many :products

  class << self
    def current_id=(id)
      Thread.current[:tenant_id] = id
    end
    
    def current_id
      Thread.current[:tenant_id]
    end
  end
end