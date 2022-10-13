class Public::ProductsController < ApplicationController
before_action :authenticate_customer!
before_action :ensure_correct_customer, { only: [:edit, :update, :destroy] }

  def create
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
    @products = Product.includes(:favorited_customers).sort {|a,b| b.favorited_customers.size <=> a.favorited_customers.size}
    #@customers = Customer.includes(:favorited_products).sort {|a,b| b.favorited_products.size <=> a.favorited_products.size}
    #@customer = @product.customer
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
