class Api::Store::StoresController < ApplicationController

  skip_before_action :authenticate_api_user!, only: [:show]

  def create
    if current_api_user.store.nil?
      @store = current_api_user.create_store!(store_params)
      obj = @store.attributes
      obj[:link_img]=url_for(@store.image)
      json_response(obj,:created)
    else
      json_response({alert:"you haved a store before"})
    end
  end

  def update
    unless current_api_user.store.nil?
      current_api_user.store.update(store_params)
      json_response(add_link_image_to_object(current_api_user.store))
    else
      json_response({alert:"you do not haved a store to updadte"})
    end
  end

  def destroy
    unless current_api_user.store.nil?
      @store = current_api_user.store
      @store.destroy
      json_response(@store)
    else
      json_response({alert:"you do not haved a store to delete"})
    end
  end

  def show
    store = Store.find_by(id: params[:id])
    if store.nil?
      json_response({alert:"do not have a store with id = #{params[:id]}"})
    else
      json_response(add_link_image_to_object(store))
    end
  end

  def store_params
    params.require(:store).permit(:name, :image, :describe)
  end
end
