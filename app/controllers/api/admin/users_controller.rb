class Api::Admin::UsersController < ApplicationController

  before_action :set_user, only: [:show, :update, :destroy]

  def index  
    render json: User.all
  end 
  
  def create
    user = User.create!(user_params)
    user.skip_confirmation!
    user.save!
    render json: user
  end
  
  def show
    render json: @user
  end

  def update
    @user.update(user_params)
    render json: @user
  end
 
  def destroy
    @user.destroy
    render json: @user
  end

    private
      def user_params 
        params.permit(:email, :name, :password, :password_confirmation) 
      end

      def set_user
        @user = User.find(params[:id])
      end
  end