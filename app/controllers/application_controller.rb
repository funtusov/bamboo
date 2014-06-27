class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  around_filter :scope_current_shop
  helper_method :current_shop

  def current_shop
    Shop.find_by domain: request.domain
  end

  def index
  end

private

  def scope_current_shop
    Shop.current_id = current_shop.id
    yield
  ensure
    Shop.current_id = nil
  end
end
