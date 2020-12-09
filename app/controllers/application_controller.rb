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

  def attach_sale(product)
    x = add_link_images_to_object(product)
    x[:comments] = product.orders.map do |order|
      c = order.comment
      unless c.nil?
        cc = c.attributes
        cc[:username] = order.user.name 
        cc
      end
    end
    x[:sale] = product.sale
    x
  end
  
  def user_res(resource)
    res = {}
    res[:id] = resource.id
    res[:name] = resource.name
    res[:email] = resource.email
    res[:image] = url_for(resource.image) if resource.image.attached?
    res[:gender] = resource.gender
    res[:address] = resource.address
    res[:phone] = resource.phone
    res[:role] = resource.role
    res[:jti] = resource.jti
    res[:token] = request.env['warden-jwt_auth.token']
    res
  end
end
