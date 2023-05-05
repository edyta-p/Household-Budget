class EntertainmentsController < ApplicationController
  def index
    @entertainment = Entertainment.new
  end

  def create
    @entertainment = Entertainment.new(entertainment_params)
    @entertainment.user = current_user
    if @entertainment.save
      flash.notice = "Expense created successfully"
      redirect_to entertainments_path
    else
      flash.alert = "Expense not created. Fulfill all the required fields!"
    end
  end

  def filter
    @entertainments = []
    if params[:query].present?
      @entertainments = Entertainment.all
      @entertainments = @entertainments.where(category: params[:query]).order(:date_of_purchase)
    end
  end

  private

  def entertainment_params
    params.require(:entertainment).permit(:category, :date_of_purchase, :amount, :shop_name, :description)
  end
end
