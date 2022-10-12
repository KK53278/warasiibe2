class Public::CommentsController < ApplicationController

  def create
    product = Product.find(params[:product_id])
    comment = current_customer.comments.new(comment_params)
    comment.product_id = product.id
    comment.save
    redirect_to public_product_path(product)
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
