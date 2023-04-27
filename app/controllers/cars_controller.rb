class CarsController < ApplicationController
  def index
    @car = Car.new
    @cars = Car.all
  end

  def create
    @car = Car.new(car_params)
    @car.user = current_user
    @car.save!
    redirect_to root_path
  end

  private

  def car_params
    params.require(:car).permit(:category, :date_of_purchase, :amount)
  end
end
