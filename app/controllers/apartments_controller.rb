class ApartmentsController < ApplicationController
  def index
    @apartment = Apartment.new
    @apartments = Apartment.all
  end

  def create
    @apartment = Apartment.new(apartment_params)
    @apartment.user = current_user
    @apartment.save!
    redirect_to root_path
  end

  private

  def apartment_params
    params.require(:apartment).permit(:category, :date_of_purchase, :amount)
  end
end
