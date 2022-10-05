class Public::CustomersController < ApplicationController

  def show
    @products = Product.all
  end

end
