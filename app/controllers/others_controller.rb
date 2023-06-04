class OthersController < ApplicationController
  def index
    @other = Other.new
    @others = Other.all
    @others = Other.order(date_of_purchase: :desc).limit(6)
    current_month = Time.now.month
    current_year = Time.now.year
    @beginning_of_month = Time.new(current_year, current_month, 1)
    @end_of_month = (@beginning_of_month + 1.month) - 1
  end

  def create
    @other = Other.new(other_params)
    @other.user = current_user
    @others = Other.all
    @others = Other.order(date_of_purchase: :desc).limit(6)
    # if @other.save
    #   flash.notice = "Expense created successfully"
    #   redirect_to others_path
    # else
    #   flash.alert = "Expense not created. Fulfill all the required fields!"
    # end

    respond_to do |format|
      if @other.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_other',
                                partial: 'form',
                                locals: { other: Other.new, others: Other.all }),
            turbo_stream.update('others',
                                partial: 'other',
                                locals: { other: @other, others: @others })]
        end
        format.html { redirect_to others_path, notice: "Expense created successfully" }
      else
        format.turbo_stream do
          render turbo_stream: [turbo_stream.update('new_other', partial: "form", locals: {other: @other})]
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def filter
    @others = []
    @currency = currency
    if params[:query].present? && params[:date_from].present? && params[:date_to].present?
      @others = Other.all
      @others = @others.where(['category = ? AND date_of_purchase >= ? AND date_of_purchase <= ?', params[:query], params[:date_from], params[:date_to]]).order(:date_of_purchase)
      @total = total
    elsif params[:query].present? && params[:date_from].present?
      @others = Other.all
      @others = @others.where('category = ? AND date_of_purchase >= ?', params[:query], params[:date_from]).order(:date_of_purchase)
      @total = total
    elsif params[:query].present? && params[:date_to].present?
      @others = Other.all
      @others = @others.where('category = ? AND date_of_purchase <= ?', params[:query], params[:date_to]).order(:date_of_purchase)
      @total = total
    elsif params[:date_from].present? && params[:date_to].present?
      @others = Other.all
      @others = @others.where(['date_of_purchase >= ? AND date_of_purchase <= ?', params[:date_from], params[:date_to]]).order(:date_of_purchase)
      @total = total
    elsif params[:date_from].present?
      @others = Other.all
      @others = @others.where('date_of_purchase >= ?', params[:date_from]).order(:date_of_purchase)
      @total = total
    elsif params[:date_to].present?
      @others = Other.all
      @others = @others.where('date_of_purchase <= ?', params[:date_to]).order(:date_of_purchase)
      @total = total
    else
      @others = Other.all
      @others = @others.where('category = ?', params[:query]).order(:date_of_purchase)
      @total = total
    end
  end

  def total
    @others.sum(:amount)
  end

  def currency
    Other.first.currency
  end

  private

  def other_params
    params.require(:other).permit(:category, :date_of_purchase, :amount, :shop_name, :description)
  end
end
