class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :current_cart

  def current_cart
    @shop = current_shop
    if ShoppingCart.where(session_id: session.id).any?
      @cart = ShoppingCart.find_by_session_id(session.id)
    else
      @cart = ShoppingCart.create!(session_id: session.id)
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:shop_name, :tag_line, :description, :vat_rate])
  end
  
end 
