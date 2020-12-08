class Api::User::CommentsController < ApplicationController
  def create
    order = Order.find_by(id: params[:order_id],user_id: current_api_user.id)
    unless order.nil?
      order.create_comment!(item_params)
      json_response({alert: "comment success"})
    else
      json_response({alert: "not have order id = #{params[:order_id]}"})
    end
  end

  def show
  end

  def destroy
    comment = Comment.find_by(id: params[:comment_id])
    if comment.order.user_id == current_api_user.id
      comment.destroy
      json_response({alert: "delete comment success"})
    else
      json_response({alert: "you dont have this comment"})
    end
  end

  private
  def item_params
    params.require(:comment).permit(:star, :content, :image)
  end
end
