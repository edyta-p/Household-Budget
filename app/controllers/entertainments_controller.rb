class EntertainmentsController < ApplicationController
  def index
    @entertainment = Entertainment.new
    @entertainments = Entertainment.all
  end

  def create
    @entertainment = Entertainment.new(entertainment_params)
    @entertainment.user = current_user
    @entertainment.save!
    redirect_to entertainments_path
  end

  def search
    @entertainments = Entertainment.all
    if params[:query].present?
      @entertainments = @entertainments.where(category: params[:query])
    end
  end


  private

  def entertainment_params
    params.require(:entertainment).permit(:category, :date_of_purchase, :amount)
  end

end
