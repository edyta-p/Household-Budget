class HealthsController < ApplicationController
  def index
    @health = Health.new
    @healths = Health.all
  end

  def create
    @health = Health.new(health_params)
    @health.user = current_user
    @health.save!
    redirect_to root_path
  end

  private

  def health_params
    params.require(:health).permit(:category, :date_of_purchase, :amount)
  end
end
