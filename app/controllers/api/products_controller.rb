class Api::ProductsController < ApplicationController
  before_action :check_param_category, only: [:index]

  def home
    categorys = add_link_image_to_array_object(Category.all)
    products_1 = add_link_images_to_array_object(Product.limit(6).offset(0))
    products_2 = add_link_images_to_array_object(Product.limit(6).offset(7))
    products_3 = add_link_images_to_array_object(Product.limit(6).offset(15))
    products_sale = Product.joins(:sale).limit(6).map do |product|
      attach_sale(product)
    end
    json_response({
      categorys: categorys,
      products_1: products_1,
      products_2: products_2,
      products_3: products_3,
      products_sale: products_sale
    })
  end

  def show
    product = Product.find_by(id: params[:id])
    unless product.nil?
      json_response(attach_sale(product))
    else
      json_response({alert: "Product does not exist"})
    end
  end

  def index
    json_response(add_link_images_to_array_object(category.products))
  end

  def create
    product = current_api_user.store.products.create!(item_params)
    json_response({status: "Create success"}, :created)
  end

  def update
  end

  def destroy
    Product.find(params[:id]).destroy!
    json_response({alert: "Delete success"})
  end

  private
  def item_params
    params.require(:product).permit(:name, :price, 
      :description, :quantityInStock, :trademark, :origin, 
      :category_id, :sendFrom, images: [])
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
