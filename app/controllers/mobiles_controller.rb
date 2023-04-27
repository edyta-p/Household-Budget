class MobilesController < ApplicationController
  def index
    @mobile = Mobile.new
    @mobiles = Mobile.all
  end

  def create
    @mobile = Mobile.new(mobile_params)
    @mobile.user = current_user
    @mobile.save!
    redirect_to root_path
  end

  private

  def mobile_params
    params.require(:mobile).permit(:category, :date_of_purchase, :amount)
  end
end
