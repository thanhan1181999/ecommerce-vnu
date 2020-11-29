class Api::User::CartsController < ApplicationController
  before_action :set_carts, only: [:index, :filter, :destroy, :update, :create]
  
  def index
    render json: @carts
  end 
  
  def filter
    if params[:ids]
      res = @carts.where(id: params[:ids])
    end
    render json: res
  end

  def create
    res = []
    params_create.each {
      |p|
      c = @carts.create(p)
      if c.valid?
        res << @carts.find(c.id)
      else
        res << error(c)
      end
    }
   
    render json: res
  end
 
  def destroy
    res = @carts.where(id: params[:ids]).delete_all
    render json: res
  end

  def update
    res = []
    params[:carts].each {
      |c|
      t = @carts.where(id:c[:id]).update(params_update(c)).first
      if t and t.valid?
        res << t
      else
        res <<  error(t)
      end
    }
    render json: res
  end

    private
      def params_create
        p = params.permit(carts: [:product_id, :quantity])
        p = p[:carts]
      end

      def params_update(p)
        p.permit(:product_id, :quantity)
      end

      def set_carts
        @carts = current_api_user.carts
      end

      def error(obj)
        if obj == nil
          mess = {}
          mess[:errors] = 1
          mess[:id] = "not exist"
          mess
        else
          mess = obj.errors.messages
          mess[:errors] = mess.size
          mess
        end
      end
end
