class Api::ProductsController < ApplicationController
  before_action :check_param_category
  def index
    json_response(category.products)
  end

  def create
    category.products.create(item_params)
    json_response(category.products, :created)
  end

  def update
  end

  def destroy
  end

  private
  def item_params
    params.require(:product).permit(:name, :picture, :price)
  end

  def check_param_category
    json_response(
      {message: "need have query param category"}, 
      :not_acceptable
    ) if category.nil?
  end

  def category
    Category.find_by(id: params[:category])
  end
end
