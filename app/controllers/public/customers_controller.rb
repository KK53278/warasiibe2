class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = Customer.find(params[:id])
    @product = Product.new
    @products = @customer.products
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
      @customer = Customer.find(params[:id])
   if @customer.update(customer_params)
      redirect_to public_customer_path(@customer.id), notice: 'You have modified successfully.'
   else
      render action: :edit
   end
  end

private

  def customer_params
    params.require(:customer).permit(:name, :introduction, :profile_image, :email, :last_name, :first_name, :post_code, :prefecture, :adress)
  end
end
