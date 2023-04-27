class MealsController < ApplicationController
  def index
    @meal = Meal.new
    @meals = Meal.all
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.user = current_user
    @meal.save!
    redirect_to root_path
  end

  private

  def meal_params
    params.require(:meal).permit(:category, :date_of_purchase, :amount)
  end
end
