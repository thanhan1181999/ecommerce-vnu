class Api::CategorysController < ApplicationController
  def index  
    json_response(Category.all)
  end 

  def create
    Category.create!(item_params)
    json_response(Category.all,:created)
  end

  def destroy
    Category.destroy(params[:id])
    json_response(Category.all)
  end 

  def update
    Category.find_by!(id: params[:id]).update(item_params)
    json_response(Category.all)
  end

  private
  def item_params 
    params.require(:category).permit(:id, :name, :picture) 
  end
end