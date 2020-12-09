class Api::User::ProfileController < ApplicationController
  def profile
    render json: current_api_user
  end
end
