class OthersController < ApplicationController
  def index
    @other = Other.new
    @others = Other.all
  end

  def create
    @other = Other.new(other_params)
    @other.user = current_user
    @other.save!
    redirect_to root_path
  end

  private

  def other_params
    params.require(:other).permit(:category, :date_of_purchase, :amount)
  end
end
