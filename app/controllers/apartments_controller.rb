# class ApartmentsController < ApplicationController
#   def index
#     @apartment = Apartment.new
#     @apartments = Apartment.all
#   end

#   def create
#     @apartment = Apartment.new(apartment_params)
#     @apartment.user = current_user
#     @apartment.save!
#     redirect_to root_path
#   end

#   private

#   def apartment_params
#     params.require(:apartment).permit(:category, :date_of_purchase, :amount)
#   end
# end
class ApartmentsController < ApplicationController
  def index
    @apartment = Apartment.new
    @apartments = Apartment.all
    @apartments = Apartment.order(date_of_purchase: :desc).limit(6)
    current_month = Time.now.month
    current_year = Time.now.year
    @beginning_of_month = Time.new(current_year, current_month, 1)
    @end_of_month = (@beginning_of_month + 1.month) - 1
  end

  def create
    @apartment = Apartment.new(apartment_params)
    @apartment.user = current_user
    @apartments = Apartment.all
    @apartments = Apartment.order(date_of_purchase: :desc).limit(6)
    # if @apartment.save
    #   flash.notice = "Expense created successfully"
    #   redirect_to apartments_path
    # else
    #   flash.alert = "Expense not created. Fulfill all the required fields!"
    # end

    respond_to do |format|
      if @apartment.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_apartment',
                                partial: 'form',
                                locals: { apartment: Apartment.new, apartments: Apartment.all }),
            turbo_stream.update('apartments',
                                partial: 'apartment',
                                locals: { apartment: @apartment, apartments: @apartments })]
        end
        format.html { redirect_to apartments_path, notice: "Expense created successfully" }
      else
        format.turbo_stream do
          render turbo_stream: [turbo_stream.update('new_apartment', partial: "form", locals: {apartment: @apartment})]
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def filter
    @apartments = []
    if params[:query].present? && params[:date_from].present? && params[:date_to].present?
      @apartments = Apartment.all
      @apartments = @apartments.where(['category = ? AND date_of_purchase >= ? AND date_of_purchase <= ?', params[:query], params[:date_from], params[:date_to]]).order(:date_of_purchase)
      @total = total
    elsif params[:query].present? && params[:date_from].present?
      @apartments = Apartment.all
      @apartments = @apartments.where('category = ? AND date_of_purchase >= ?', params[:query], params[:date_from]).order(:date_of_purchase)
      @total = total
    elsif params[:query].present? && params[:date_to].present?
      @apartments = Apartment.all
      @apartments = @apartments.where('category = ? AND date_of_purchase <= ?', params[:query], params[:date_to]).order(:date_of_purchase)
      @total = total
    elsif params[:date_from].present? && params[:date_to].present?
      @apartments = Apartment.all
      @apartments = @apartments.where(['date_of_purchase >= ? AND date_of_purchase <= ?', params[:date_from], params[:date_to]]).order(:date_of_purchase)
      @total = total
    elsif params[:date_from].present?
      @apartments = Apartment.all
      @apartments = @apartments.where('date_of_purchase >= ?', params[:date_from]).order(:date_of_purchase)
      @total = total
    elsif params[:date_to].present?
      @apartments = Apartment.all
      @apartments = @apartments.where('date_of_purchase <= ?', params[:date_to]).order(:date_of_purchase)
      @total = total
    else
      @apartments = Apartment.all
      @apartments = @apartments.where('category = ?', params[:query]).order(:date_of_purchase)
      @total = total
    end
  end

  def total
    @apartments.sum(:amount)
  end

  private

  def apartment_params
    params.require(:apartment).permit(:category, :date_of_purchase, :amount, :shop_name, :description)
  end
end
