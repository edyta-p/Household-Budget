class SavingsController < ApplicationController
  def index
    @saving = Saving.new
    @savings = Saving.all
  end

  def create
    @saving = Saving.new(saving_params)
    @saving.user = current_user
    @saving.save!
    redirect_to root_path
  end

  private

  def saving_params
    params.require(:saving).permit(:category, :date_of_purchase, :amount)
  end
end
