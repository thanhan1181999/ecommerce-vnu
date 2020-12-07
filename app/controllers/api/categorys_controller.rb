class Api::CategorysController < ApplicationController
  skip_before_action :authenticate_api_user!

  def index
    categorys = Category.all
    if params[:attach_product].nil?
      result=[]
      categorys.each do |category|
        products = category.products
        x = add_link_image_to_object(category)
        x[:products] = add_link_images_to_array_object(products)
        result += [x]
      end
      json_response(result)
    else
      json_response(add_link_image_to_array_object(categorys))
    end
  end

  def create
    @category = Category.create!(item_params)
    json_response(add_link_image_to_object(@category),:created)
  end

  # def destroy
  #   @category = Category.find_by(params[:id])
  #   @category.image.purge_later
  #   @category.destroy
  #   json_response({alert: "Delete success"})
  # end

  def update
    @category = Category.find_by!(id: params[:id]).update(item_params)
    json_response(add_link_image_to_object(@category))
  end

  private
  def item_params 
    params.require(:category).permit(:id, :name, :image) 
  end
end