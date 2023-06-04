class SavingsController < ApplicationController
  def index
    @saving = Saving.new
    @savings = Saving.all
    @savings = Saving.order(date_of_transaction: :desc).limit(6)
    current_month = Time.now.month
    current_year = Time.now.year
    @beginning_of_month = Time.new(current_year, current_month, 1)
    @end_of_month = (@beginning_of_month + 1.month) - 1
  end

  def create
    @saving = Saving.new(saving_params)
    @saving.user = current_user
    @savings = Saving.all
    @savings = Saving.order(date_of_transaction: :desc).limit(6)
    # if @saving.save
    #   flash.notice = "Expense created successfully"
    #   redirect_to savings_path
    # else
    #   flash.alert = "Expense not created. Fulfill all the required fields!"
    # end

    respond_to do |format|
      if @saving.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_saving',
                                partial: 'form',
                                locals: { saving: Saving.new, savings: Saving.all }),
            turbo_stream.update('savings',
                                partial: 'saving',
                                locals: { saving: @saving, savings: @savings })]
        end
        format.html { redirect_to savings_path, notice: "Expense created successfully" }
      else
        format.turbo_stream do
          render turbo_stream: [turbo_stream.update('new_saving', partial: "form", locals: {saving: @saving})]
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def filter
    @savings = []
    @currency = currency
    if params[:query].present? && params[:date_from].present? && params[:date_to].present?
      @savings = Saving.all
      @savings = @savings.where(['category = ? AND date_of_transaction >= ? AND date_of_transaction <= ?', params[:query], params[:date_from], params[:date_to]]).order(:date_of_transaction)
      @total = total
    elsif params[:query].present? && params[:date_from].present?
      @savings = Saving.all
      @savings = @savings.where('category = ? AND date_of_transaction >= ?', params[:query], params[:date_from]).order(:date_of_transaction)
      @total = total
    elsif params[:query].present? && params[:date_to].present?
      @savings = Saving.all
      @savings = @savings.where('category = ? AND date_of_transaction <= ?', params[:query], params[:date_to]).order(:date_of_transaction)
      @total = total
    elsif params[:date_from].present? && params[:date_to].present?
      @savings = Saving.all
      @savings = @savings.where(['date_of_transaction >= ? AND date_of_transaction <= ?', params[:date_from], params[:date_to]]).order(:date_of_transaction)
      @total = total
    elsif params[:date_from].present?
      @savings = Saving.all
      @savings = @savings.where('date_of_transaction >= ?', params[:date_from]).order(:date_of_transaction)
      @total = total
    elsif params[:date_to].present?
      @savings = Saving.all
      @savings = @savings.where('date_of_transaction <= ?', params[:date_to]).order(:date_of_transaction)
      @total = total
    else
      @savings = Saving.all
      @savings = @savings.where('category = ?', params[:query]).order(:date_of_transaction)
      @total = total
    end
  end

  def total
    @savings.sum(:amount)
  end

  def currency
    Saving.first.currency
  end

  private

  def saving_params
    params.require(:saving).permit(:category, :date_of_transaction, :amount, :placement, :description)
  end
end
