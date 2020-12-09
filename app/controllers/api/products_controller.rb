class Api::ProductsController < ApplicationController
  skip_before_action :authenticate_api_user!

  before_action :authenticate_api_user!, only: [:create, :update, :destroy]
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
    if !category.nil?
      json_response(add_link_images_to_array_object(category.products))
    elsif !store.nil?
      json_response(add_link_images_to_array_object(store.products))
    else
      json_response({status: "no have category or store"})
    end
  end

  def create
    if current_api_user.store.nil?
      json_response({alert: "must create the store"}) 
    else
      product = current_api_user.store.products.create!(item_params)
      json_response({status: "Create success"}, :created)
    end
  end

  def update
    product = Product.find_by!(id: params[:id])
    if product.store.user.id == current_api_user.id
      Product.find_by!(id: params[:id]).update(item_params)
      product = Product.find_by!(id: params[:id])
      json_response(add_link_images_to_object(product))
    else
      json_response({alert:"you can not update this product"})
    end
  end

  def destroy
    pr = current_api_user.store.products.where(id: params[:id])[0]
    unless pr.nil?
      pr.destroy
      json_response({alert: "Delete success"})
    else
      json_response({alert: "you donot have product with id = #{params[:id]}"})
    end
  end

  private
  def item_params
    params.require(:product).permit(:name, :price, 
      :description, :quantityInStock, :trademark, :origin, 
      :category_id, :sendFrom, images: [])
  end

  def category
    Category.find_by(id: params[:category])
  end

  def store
    Store.find_by(id: params[:store])
  end
end
