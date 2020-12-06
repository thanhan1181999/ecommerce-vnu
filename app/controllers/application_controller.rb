class ApplicationController < ActionController::API
  # protect_from_forgery with: :null_session
  include Response
  include ExceptionHandler
  respond_to :json
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_api_user!

  def configure_permitted_parameters
    added_attrs = %i[username email password password_confirmation remember_me name]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def add_link_image_to_array_object(array)
    result=[]
    array.each do |x|
      obj = x.attributes
      obj[:link_img] = url_for(x.image) if x.image.attached?
      result += [obj]
    end
    result
  end

  def add_link_images_to_array_object(array)
    result=[]
    array.each do |x|
      obj = x.attributes
      if x.images.attached?
        obj[:link_img]=[]
        0.upto(x.images.length()-1) do |i|
          obj[:link_img] += [url_for(x.images[i])]
        end
      end
      result += [obj]
    end
    result
  end

  def add_link_image_to_object(record)
    obj = record.attributes
    obj[:link_img] = url_for(record.image) if record.image.attached?
    obj
  end

  def add_link_images_to_object(record)
    obj = record.attributes
    obj[:link_img]=[]
    0.upto(record.images.length()-1) do |i|
      obj[:link_img] += [url_for(record.images[i])]
    end
    obj
  end

end
