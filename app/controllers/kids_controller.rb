class KidsController < ApplicationController
  def index
    @kid = Kid.new
    @kids = Kid.all
  end

  def create
    @kid = Kid.new(kid_params)
    @kid.user = current_user
    @kid.save!
    redirect_to root_path
  end

  private

  def kid_params
    params.require(:kid).permit(:category, :date_of_purchase, :amount)
  end
end
