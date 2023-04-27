class RepaymentsController < ApplicationController
  def index
    @repayment = Repayment.new
    @repayments = Repayment.all
  end

  def create
    @repayment = Repayment.new(repayment_params)
    @repayment.user = current_user
    @repayment.save!
    redirect_to root_path
  end

  private

  def repayment_params
    params.require(:repayment).permit(:category, :date_of_purchase, :amount)
  end
end
