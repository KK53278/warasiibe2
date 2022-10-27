class Public::ProductsController < ApplicationController
before_action :authenticate_customer!
before_action :ensure_correct_customer, { only: [:edit, :update, :destroy] }

  def create
    @product = Product.new(product_params)
    @product.customer_id = current_customer.id
    @customer = current_customer
    if @product.save
      @products = @customer.products.page(params[:page]).per(5)
      redirect_to public_customer_path(@customer)
    else
      @products = @customer.products.page(params[:page]).per(5)
      render 'public/customers/show'
    end
  end

  def index
    @products = Product.all.page(params[:page]).per(5)
    @all_ranks = Product.create_all_ranks
  end

  def show
    @product = Product.find(params[:id])
    @customer = current_customer
    @comment = Comment.new
  end

  def edit
        @product = Product.find(params[:id])
    if  @product.customer == current_customer
        render "edit"
    else
        redirect_to public_products_path(@product.id)
    end
  end

  def update
    if @product.update(product_params)
      redirect_to public_product_path, notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
        @product = Product.find(params[:id])
    if  @product.customer == current_customer
        @product.destroy
        redirect_to public_products_path
    end
  end

  private

  def product_params
    params.require(:product).permit(:product_name, :caption, images: [])
  end

  def ensure_correct_customer
      @product = Product.find(params[:id])
      @customer = @product.customer
    if current_customer != @customer
      redirect_to products_path
    end
  end

end
