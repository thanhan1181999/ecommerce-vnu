class Api::User::OrdersController < ApplicationController
  before_action :set_orders, only: %i[index filter cancel]
  before_action :set_params_create, only: [:create]
  

  def index
    render json: @orders
  end

  def filter
    @orders = current_api_user.orders
    @orders = @orders.where(id: params[:ids]) if params[:ids]
    render json: @orders
  end

  def create
    @orders = current_api_user.orders.create(@params_create)
    render json: @orders
  end

  def cancel
    current_api_user.orders.where(id: params[:ids])
                    .update_all(state: 'user_cancel')
    @orders = current_api_user.orders.find(params[:ids])
    render json: @orders
  end

  private

  def set_params_create
    p = params.permit(orders: %i[product_id quantity])

    # cannot order from your own store
    orders = p[:orders]
    orders.each do |o|
      if current_api_user.store.id == Product.find(o[:product_id]).store.id
        return render plain: 'cannot order from your own store', status: 403
      end
    end
    @params_create = orders
  end

  def set_orders
    @orders = current_api_user.orders
  end
end
