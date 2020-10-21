class Api::OrdersController < ApplicationController
  before_action :set_order, only: [:show,:update, :destroy]

  def index  
    render json: Order.export(current_api_user)
  end 
  
  def create
    order = current_api_user.orders.create!(order_params)
    render json: order.export
  end
  
  def show
    render json: @order.export
  end

  def update
    @order.update(order_params)
    render json: @order
  end
 
  def destroy
    @order.destroy
    render json: @order
  end

    private
      def order_params 
        params.permit(:product_id, :quantity) 
      end

      def set_order
        @order = current_api_user.orders.find(params[:id])
      end

end
