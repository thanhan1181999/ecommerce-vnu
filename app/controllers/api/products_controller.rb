class Api::ProductsController < ApplicationController
  before_action :check_param_category, only: [:index, :create]
  def index
    json_response(add_link_images_to_array_object(category.products))
  end

  def create
    product = category.products.create(item_params)
    json_response({status: "success"}, :created)
  end

  def update
  end

  def destroy
    Product.find(params[:id]).destroy!
    head :no_content
  end

  private
  def item_params
    params.require(:product).permit(:name, :price, 
      :description, :quantityInstock, :trademark, :origin, :sendFrom, images: [])
  end

  def check_param_category
    json_response(
      {message: "this category is not exist"}, 
      :not_acceptable
    ) if category.nil?
  end

  def category
    Category.find_by(id: params[:category])
  end
end
