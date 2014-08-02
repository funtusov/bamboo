class UserSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :id, :signed_in, :first_name, :last_name, :email

  has_one :cart
end