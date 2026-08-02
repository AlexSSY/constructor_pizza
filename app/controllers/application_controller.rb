class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    current_user.present?
  end

  helper_method :current_user

  def authenticate_user!
    redirect_to login_path, alert: "You must be logged in to access this page." unless current_user
  end

  def current_cart
    @current_cart ||= Cart.find_by(id: session[:cart_id]) || Cart.create.tap { |cart| session[:cart_id] = cart.id }
  end
end
