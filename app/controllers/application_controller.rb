class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  around_filter :scope_current_shop

  helper_method :current_shop

  alias_method :devise_current_user, :current_user

  def current_shop
    Shop.find_by domain: request.domain
  end

  def current_user
    @current_user ||= if devise_current_user
      devise_current_user
    else
      sign_in(:user, current_shop.users.create!)
    end
  end

  def index
    gon.push(current_user_id: current_user.id)
  end

  private

  def scope_current_shop
    Shop.current_id = current_shop.id
    yield
  ensure
    Shop.current_id = nil
  end
end
