class Public::CommentsController < ApplicationController

  def create
    product = Product.find(params[:product_id])
    comment = current_customer.comments.new(comment_params)
    comment.product_id = product.id
    if comment.save
      product.create_notification_comment!(current_customer, comment.id)
      redirect_to public_product_path(product)
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to public_product_path(params[:product_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
