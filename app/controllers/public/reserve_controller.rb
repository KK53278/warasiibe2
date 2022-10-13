class Public::ReserveController < ApplicationController
  before_action :permit_params, except: :new

  def new
    @reserve = Reserve.new
  end

  def back
    @reserve = Reserve.new(@attr)
		render :new
  end

  def confirm
    @reserve = Reserve.new(@attr)
		if @reserve.invalid?
			render :new
		end
  end

  def complete
    Reserve.create!(@attr)
  end

  private

  def permit_params
		@attr = params.require('reserve').permit(:id, :zip, :adress, :name, :note)
	end
end
