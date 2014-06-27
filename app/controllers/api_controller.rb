class ApiController < ApplicationController
  respond_to :json

  rescue_from Mongoid::Errors::DocumentNotFound, with: :not_found

private

  def not_found
    respond_with '{"error": "not_found"}', status: :not_found
  end
end