class ApplicationController < ActionController::API
  # protect_from_forgery with: :null_session
  include Response
  include ExceptionHandler
  respond_to :json
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_api_user!

  def configure_permitted_parameters
    added_attrs = %i[username email password password_confirmation remember_me name]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
