class ApplicationController < ActionController::Base
acts_as_token_authentication_handler_for User

protect_from_forgery with: :exception
skip_before_action :verify_authenticity_token,if: :json_request?
skip_before_action :authenticate_user!


protected

def json_request?
    request.format.json?
end

before_action :configure_devise_permitted_parameters, if: :devise_controller?

  protected

  def configure_devise_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :username, :name, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password_confirmation, :current_password) }
  end

  before_filter :set_cache_headers

  private

  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

end
