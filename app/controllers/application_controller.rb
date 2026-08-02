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
    @current_cart ||= begin
      if user_signed_in?
        cart = get_or_create_cart
        cart.user = current_user if cart.user.nil?
        cart.save! if cart.changed?
      else

      end
      cart = Cart.find_by(id: session[:cart_id])
      if cart.nil?
        cart = current_user&.cart || Cart.create
        session[:cart_id] = cart.id
      end
      cart
    end
  end

  private

  def get_or_create_cart
    Cart.find_by(id: session[:cart_id]) || Cart.create
  end
end
