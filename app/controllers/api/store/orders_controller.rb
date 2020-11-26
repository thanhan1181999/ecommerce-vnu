class Api::Store::OrdersController < ApplicationController
  before_action :set_orders, only: [:index, :filter, :cancel, :accept]
  
  def index
    render json: @orders
  end 
  
  def filter
    if params[:id]
      @orders = @orders.where(id: params[:id])
    end
    render json: @orders
  end

  def accept
    @orders.where(id: params[:ids]).
                                update_all(state: "store_accepted")
    @orders = @orders.find(params[:ids])
    render json: @orders
  end
 
  def cancel
    @orders.where(id: params[:ids]).
                                update_all(state: "store_cancel")
    @orders = @orders.find(params[:ids])
    render json: @orders
  end
    private
      def set_orders
        @orders = current_api_user.store.orders
      end
end
