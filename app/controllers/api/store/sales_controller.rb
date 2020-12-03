class Api::Store::SalesController < ApplicationController
  def index
    render json: current_api_user.store.sales
  end

  def show
    render json: Sale.find(params[:id])
  end

  def create
    product = current_api_user.store.products.find(params[:product_id])
    if product
      if product.sale
        render json: "sale of product_id = #{params[:product_id]} has already exist", status: 422
      else
        sale = product.create_sale(params.permit(:quantity, :from, :to, :promotion))
        render json: sale
      end
    else
      render json: "your store has not product_id = #{params[:product_id]}", status: 422
    end
  end

  def update
    sale = Sale.find(params[:id])
    product = current_api_user.store.products.find(sale.product.id)
    if product
      sale.update(params.permit(:quantity, :from, :to, :promotion))
      render json: sale
    else
      render json: "your store has not sale_id = #{params[:id]}", status: 422
    end
  end

  def destroy
    sale = Sale.find(params[:id])
    product = current_api_user.store.products.find(sale.product.id)
    if product
      render json: sale.destroy
    else
      render json: "your store has not sale id = #{params[:id]}", status: 422
    end
  end

end
