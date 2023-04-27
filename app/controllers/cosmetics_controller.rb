class CosmeticsController < ApplicationController
  def index
    @cosmetic = Cosmetic.new
    @cosmetics = Cosmetic.all
  end

  def create
    @cosmetic = Cosmetic.new(cosmetic_params)
    @cosmetic.user = current_user
    @cosmetic.save!
    redirect_to root_path
  end

  private

  def cosmetic_params
    params.require(:cosmetic).permit(:category, :date_of_purchase, :amount)
  end
end
