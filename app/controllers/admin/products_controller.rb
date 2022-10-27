class Admin::ProductsController < ApplicationController
  def index
    @products = Product.all.page(params[:page]).per(6)
  end

  def show
    @product = Product.find(params[:id])
  end
end
