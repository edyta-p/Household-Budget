class ClothingsController < ApplicationController
  def index
    @clothing = Clothing.new
    @clothings = Clothing.all
  end

  def create
    @clothing = Clothing.new(clothing_params)
    @clothing.user = current_user
    @clothing.save!
    redirect_to root_path
  end

  private

  def clothing_params
    params.require(:clothing).permit(:category, :date_of_purchase, :amount)
  end
end
