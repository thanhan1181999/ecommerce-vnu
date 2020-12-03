class Api::User::SalesController < ApplicationController
  skip_before_action :authenticate_api_user!
  def index
    render json: Sale.all
  end

  def show
    render json: Sale.find(params[:id])
  end
end
