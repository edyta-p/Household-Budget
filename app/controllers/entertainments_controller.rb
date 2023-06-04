class EntertainmentsController < ApplicationController
  def index
    @entertainment = Entertainment.new
    @entertainments = Entertainment.all
    @entertainments = Entertainment.order(date_of_purchase: :desc).limit(6)
    current_month = Time.now.month
    current_year = Time.now.year
    @beginning_of_month = Time.new(current_year, current_month, 1)
    @end_of_month = (@beginning_of_month + 1.month) - 1
  end

  def create
    @entertainment = Entertainment.new(entertainment_params)
    @entertainment.user = current_user
    @entertainments = Entertainment.all
    @entertainments = Entertainment.order(date_of_purchase: :desc).limit(6)
    # if @entertainment.save
    #   flash.notice = "Expense created successfully"
    #   redirect_to entertainments_path
    # else
    #   flash.alert = "Expense not created. Fulfill all the required fields!"
    # end

    respond_to do |format|
      if @entertainment.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_entertainment',
                                partial: 'form',
                                locals: { entertainment: Entertainment.new, entertainments: Entertainment.all }),
            turbo_stream.update('entertainments',
                                partial: 'entertainment',
                                locals: { entertainment: @entertainment, entertainments: @entertainments })]
        end
        format.html { redirect_to entertainments_path, notice: "Expense created successfully" }
      else
        format.turbo_stream do
          render turbo_stream: [turbo_stream.update('new_entertainment', partial: "form", locals: {entertainment: @entertainment})]
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def filter
    @entertainments = []
    @currency = currency
    if params[:query].present? && params[:date_from].present? && params[:date_to].present?
      @entertainments = Entertainment.all
      @entertainments = @entertainments.where(['category = ? AND date_of_purchase >= ? AND date_of_purchase <= ?', params[:query], params[:date_from], params[:date_to]]).order(:date_of_purchase)
      @total = total
    elsif params[:query].present? && params[:date_from].present?
      @entertainments = Entertainment.all
      @entertainments = @entertainments.where('category = ? AND date_of_purchase >= ?', params[:query], params[:date_from]).order(:date_of_purchase)
      @total = total
    elsif params[:query].present? && params[:date_to].present?
      @entertainments = Entertainment.all
      @entertainments = @entertainments.where('category = ? AND date_of_purchase <= ?', params[:query], params[:date_to]).order(:date_of_purchase)
      @total = total
    elsif params[:date_from].present? && params[:date_to].present?
      @entertainments = Entertainment.all
      @entertainments = @entertainments.where(['date_of_purchase >= ? AND date_of_purchase <= ?', params[:date_from], params[:date_to]]).order(:date_of_purchase)
      @total = total
    elsif params[:date_from].present?
      @entertainments = Entertainment.all
      @entertainments = @entertainments.where('date_of_purchase >= ?', params[:date_from]).order(:date_of_purchase)
      @total = total
    elsif params[:date_to].present?
      @entertainments = Entertainment.all
      @entertainments = @entertainments.where('date_of_purchase <= ?', params[:date_to]).order(:date_of_purchase)
      @total = total
    else
      @entertainments = Entertainment.all
      @entertainments = @entertainments.where('category = ?', params[:query]).order(:date_of_purchase)
      @total = total
    end
  end

  def total
    @entertainments.sum(:amount)
  end

  def currency
    Entertainment.first.currency
  end

  private

  def entertainment_params
    params.require(:entertainment).permit(:category, :date_of_purchase, :amount, :shop_name, :description)
  end
end
