class Api::ProductsController < ApplicationController
  respond_to :json

  def index
    respond_with({products: [1,2,3]}.to_json)
  end
end