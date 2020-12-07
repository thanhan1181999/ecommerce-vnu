class Api::User::CommentsController < ApplicationController
  skip_before_action :authenticate_api_user!
  def create
    order = Order.find_by(id: params[:order_id])
    order.create_comment!(item_params)
    json_response({alert: "comment success"})
  end

  def show
  end

  def destroy
    Comment.find_by(id: params[:comment_id])&.destroy
    json_response({alert: "delete comment success"})
  end

  private
  def item_params
    params.require(:comment).permit(:star, :content, :image)
  end
end
