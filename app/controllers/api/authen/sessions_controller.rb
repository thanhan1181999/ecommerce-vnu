# frozen_string_literal: true

class Api::Authen::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?

    res = {}
    res[:id] = resource.id
    res[:name] = resource.name
    res[:email] = resource.email
    res[:image] = url_for(resource.image) if resource.image.attached?
    res[:gender] = resource.gender
    res[:address] = resource.address
    res[:role] = resource.role
    res[:jti] = resource.jti
    res[:token] = request.env['warden-jwt_auth.token']

    respond_with res, location: after_sign_in_path_for(resource)
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end


end
