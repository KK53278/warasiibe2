class Public::ProductsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]


  def create
    # binding.pry

    @product = Product.new(product_params)
    @product.customer_id = current_customer.id
    @customer = current_customer
    if @product.save
      redirect_to public_customer_path(@customer)
    else
      render 'customer/show'
    end
  end

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def destroy
  end

  private

  def product_params
    params.require(:product).permit(:product_name, :caption, :image)
  end


end
