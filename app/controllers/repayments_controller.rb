class RepaymentsController < ApplicationController
  def index
    @repayment = Repayment.new
    @repayments = Repayment.all
    @repayments = Repayment.order(date_of_transaction: :desc).limit(6)
    current_month = Time.now.month
    current_year = Time.now.year
    @beginning_of_month = Time.new(current_year, current_month, 1)
    @end_of_month = (@beginning_of_month + 1.month) - 1
  end

  def create
    @repayment = Repayment.new(repayment_params)
    @repayment.user = current_user
    @repayments = Repayment.all
    @repayments = Repayment.order(date_of_transaction: :desc).limit(6)
    # if @repayment.save
    #   flash.notice = "Expense created successfully"
    #   redirect_to repayments_path
    # else
    #   flash.alert = "Expense not created. Fulfill all the required fields!"
    # end

    respond_to do |format|
      if @repayment.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_repayment',
                                partial: 'form',
                                locals: { repayment: Repayment.new, repayments: Repayment.all }),
            turbo_stream.update('repayments',
                                partial: 'repayment',
                                locals: { repayment: @repayment, repayments: @repayments })]
        end
        format.html { redirect_to repayments_path, notice: "Expense created successfully" }
      else
        format.turbo_stream do
          render turbo_stream: [turbo_stream.update('new_repayment', partial: "form", locals: {repayment: @repayment})]
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def filter
    @repayments = []
    @currency = currency
    if params[:query].present? && params[:date_from].present? && params[:date_to].present?
      @repayments = Repayment.all
      @repayments = @repayments.where(['category = ? AND date_of_transaction >= ? AND date_of_transaction <= ?', params[:query], params[:date_from], params[:date_to]]).order(:date_of_transaction)
      @total = total
    elsif params[:query].present? && params[:date_from].present?
      @repayments = Repayment.all
      @repayments = @repayments.where('category = ? AND date_of_transaction >= ?', params[:query], params[:date_from]).order(:date_of_transaction)
      @total = total
    elsif params[:query].present? && params[:date_to].present?
      @repayments = Repayment.all
      @repayments = @repayments.where('category = ? AND date_of_transaction <= ?', params[:query], params[:date_to]).order(:date_of_transaction)
      @total = total
    elsif params[:date_from].present? && params[:date_to].present?
      @repayments = Repayment.all
      @repayments = @repayments.where(['date_of_transaction >= ? AND date_of_transaction <= ?', params[:date_from], params[:date_to]]).order(:date_of_transaction)
      @total = total
    elsif params[:date_from].present?
      @repayments = Repayment.all
      @repayments = @repayments.where('date_of_transaction >= ?', params[:date_from]).order(:date_of_transaction)
      @total = total
    elsif params[:date_to].present?
      @repayments = Repayment.all
      @repayments = @repayments.where('date_of_transaction <= ?', params[:date_to]).order(:date_of_transaction)
      @total = total
    else
      @repayments = Repayment.all
      @repayments = @repayments.where('category = ?', params[:query]).order(:date_of_transaction)
      @total = total
    end
  end

  def total
    @repayments.sum(:amount)
  end

  def currency
    Repayment.first.currency
  end

  private

  def repayment_params
    params.require(:repayment).permit(:category, :date_of_transaction, :amount, :lender, :description)
  end
end
