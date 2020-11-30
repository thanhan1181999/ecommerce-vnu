class Api::Store::StoresController < ApplicationController
  def create
    if current_api_user.store.nil?
      @store = current_api_user.create_store!(store_params)
      obj = @store.attributes
      obj[:link_img]=url_for(@store.image)
      json_response(obj,:created)
    else
      json_response({alert:"not success"})
    end
  end

  def destroy
    unless current_api_user.store.nil?
      @store = current_api_user.store
      @store.image.purge_later
      @store.destroy
      json_response(@store)
    else
      json_response({alert:"not success"})
    end
  end

  def store_params
    params.require(:store).permit(:name, :image, :describe)
  end
end
