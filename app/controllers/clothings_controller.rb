class ClothingsController < ApplicationController
  def index
    @clothing = Clothing.new
    @clothings = Clothing.all
    @clothings = Clothing.order(date_of_purchase: :desc).limit(6)
    current_month = Time.now.month
    current_year = Time.now.year
    @beginning_of_month = Time.new(current_year, current_month, 1)
    @end_of_month = (@beginning_of_month + 1.month) - 1
  end

  def create
    @clothing = Clothing.new(clothing_params)
    @clothing.user = current_user
    @clothings = Clothing.all
    @clothings = Clothing.order(date_of_purchase: :desc).limit(6)
    # if @clothing.save
    #   flash.notice = "Expense created successfully"
    #   redirect_to clothings_path
    # else
    #   flash.alert = "Expense not created. Fulfill all the required fields!"
    # end

    respond_to do |format|
      if @clothing.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_clothing',
                                partial: 'form',
                                locals: { clothing: Clothing.new, clothings: Clothing.all }),
            turbo_stream.update('clothings',
                                partial: 'clothing',
                                locals: { clothing: @clothing, clothings: @clothings })]
        end
        format.html { redirect_to clothings_path, notice: "Expense created successfully" }
      else
        format.turbo_stream do
          render turbo_stream: [turbo_stream.update('new_clothing', partial: "form", locals: {clothing: @clothing})]
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def filter
    @clothings = []
    @currency = currency
    if params[:query].present? && params[:date_from].present? && params[:date_to].present?
      @clothings = Clothing.all
      @clothings = @clothings.where(['category = ? AND date_of_purchase >= ? AND date_of_purchase <= ?', params[:query], params[:date_from], params[:date_to]]).order(:date_of_purchase)
      @total = total
    elsif params[:query].present? && params[:date_from].present?
      @clothings = Clothing.all
      @clothings = @clothings.where('category = ? AND date_of_purchase >= ?', params[:query], params[:date_from]).order(:date_of_purchase)
      @total = total
    elsif params[:query].present? && params[:date_to].present?
      @clothings = Clothing.all
      @clothings = @clothings.where('category = ? AND date_of_purchase <= ?', params[:query], params[:date_to]).order(:date_of_purchase)
      @total = total
    elsif params[:date_from].present? && params[:date_to].present?
      @clothings = Clothing.all
      @clothings = @clothings.where(['date_of_purchase >= ? AND date_of_purchase <= ?', params[:date_from], params[:date_to]]).order(:date_of_purchase)
      @total = total
    elsif params[:date_from].present?
      @clothings = Clothing.all
      @clothings = @clothings.where('date_of_purchase >= ?', params[:date_from]).order(:date_of_purchase)
      @total = total
    elsif params[:date_to].present?
      @clothings = Clothing.all
      @clothings = @clothings.where('date_of_purchase <= ?', params[:date_to]).order(:date_of_purchase)
      @total = total
    else
      @clothings = Clothing.all
      @clothings = @clothings.where('category = ?', params[:query]).order(:date_of_purchase)
      @total = total
    end
  end

  def total
    @clothings.sum(:amount)
  end

  def currency
    Clothing.first.currency
  end

  private

  def clothing_params
    params.require(:clothing).permit(:category, :date_of_purchase, :amount, :shop_name, :description)
  end
end
