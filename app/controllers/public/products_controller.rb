class Public::ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def create
    product = Product.new(product_params)
    product.save
    redirect_to '/show'
  end

  def index
    @products = Product.all
  end

  def show
  end

  def edit
  end

  private

  def product_params
    params.require(:product).permit(:introduction)
  end


end
