class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  around_filter :scope_current_shop
  before_filter :create_current_user, only: [:index]

  helper_method :current_shop

  def current_shop
    Shop.find_by domain: request.domain
  end

  alias_method :devise_current_user, :current_user

  def current_user
    @current_user ||= if devise_current_user
      devise_current_user
    else
      user = current_shop.users.create!
      sign_in(:user, user)
      user
    end
  end

  def index
  end

private

  def create_current_user
    current_user
  end

  def scope_current_shop
    Shop.current_id = current_shop.id
    yield
  ensure
    Shop.current_id = nil
  end
end
