class ApplicationController < ActionController::API
  # protect_from_forgery with: :null_session
  include Response
  include ExceptionHandler
  respond_to :json
end
