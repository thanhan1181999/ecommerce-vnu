class Api::CategorysController < ApplicationController
  def index  
    json_response(add_link_image_to_array_object(Category.all))
  end 

  def create
    @category = Category.create!(item_params)
    obj = @category.attributes
    obj[:link_img]=url_for(@category.image)
    json_response(obj,:created)
  end

  def destroy
    @category = Category.find_by(params[:id])
    @category.image.purge_later
    @category.destroy
    head :no_content
  end

  def update
    @category = Category.find_by!(id: params[:id]).update(item_params)
    obj = @category.attributes
    obj[:link_img]=url_for(@category.image)
    json_response(obj)
  end

  private
  def item_params 
    params.require(:category).permit(:id, :name, :image) 
  end
end