class Public::FavoritesController < ApplicationController

  def create
    @product = Product.find(params[:product_id])
    favorite = current_customer.favorites.new(product_id: @product.id)
    favorite.save
    render 'public/favorites/replace_btn'
  end

  def destroy
    @product = Product.find(params[:product_id])
    favorite = current_customer.favorites.find_by(product_id: @product.id)
    favorite.destroy
  end

end
