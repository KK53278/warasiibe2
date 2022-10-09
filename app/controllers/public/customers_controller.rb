class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!


  def show
    @customer = Customer.find(params[:id])
    @product = Product.new
    @products = @customer.products
  end


private

  def customer_params
    params.require(:customer).permit(:name, :introduction, :email, :last_name, :first_name, :post_code, :prefecture, :adress)
  end
end
