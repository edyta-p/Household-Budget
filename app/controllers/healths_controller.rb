class HealthsController < ApplicationController
  def index
    @health = Health.new
    @healths = Health.all
    @healths = Health.order(date_of_purchase: :desc).limit(6)
    current_month = Time.now.month
    current_year = Time.now.year
    @beginning_of_month = Time.new(current_year, current_month, 1)
    @end_of_month = (@beginning_of_month + 1.month) - 1
  end

  def create
    @health = Health.new(health_params)
    @health.user = current_user
    @healths = Health.all
    @healths = Health.order(date_of_purchase: :desc).limit(6)
    # if @health.save
    #   flash.notice = "Expense created successfully"
    #   redirect_to healths_path
    # else
    #   flash.alert = "Expense not created. Fulfill all the required fields!"
    # end

    respond_to do |format|
      if @health.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_health',
                                partial: 'form',
                                locals: { health: Health.new, healths: Health.all }),
            turbo_stream.update('healths',
                                partial: 'health',
                                locals: { health: @health, healths: @healths })]
        end
        format.html { redirect_to healths_path, notice: "Expense created successfully" }
      else
        format.turbo_stream do
          render turbo_stream: [turbo_stream.update('new_health', partial: "form", locals: {health: @health})]
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def filter
    @healths = []
    @currency = currency
    if params[:query].present? && params[:date_from].present? && params[:date_to].present?
      @healths = Health.all
      @healths = @healths.where(['category = ? AND date_of_purchase >= ? AND date_of_purchase <= ?', params[:query], params[:date_from], params[:date_to]]).order(:date_of_purchase)
      @total = total
    elsif params[:query].present? && params[:date_from].present?
      @healths = Health.all
      @healths = @healths.where('category = ? AND date_of_purchase >= ?', params[:query], params[:date_from]).order(:date_of_purchase)
      @total = total
    elsif params[:query].present? && params[:date_to].present?
      @healths = Health.all
      @healths = @healths.where('category = ? AND date_of_purchase <= ?', params[:query], params[:date_to]).order(:date_of_purchase)
      @total = total
    elsif params[:date_from].present? && params[:date_to].present?
      @healths = Health.all
      @healths = @healths.where(['date_of_purchase >= ? AND date_of_purchase <= ?', params[:date_from], params[:date_to]]).order(:date_of_purchase)
      @total = total
    elsif params[:date_from].present?
      @healths = Health.all
      @healths = @healths.where('date_of_purchase >= ?', params[:date_from]).order(:date_of_purchase)
      @total = total
    elsif params[:date_to].present?
      @healths = Health.all
      @healths = @healths.where('date_of_purchase <= ?', params[:date_to]).order(:date_of_purchase)
      @total = total
    else
      @healths = Health.all
      @healths = @healths.where('category = ?', params[:query]).order(:date_of_purchase)
      @total = total
    end
  end

  def total
    @healths.sum(:amount)
  end

  def currency
    Health.first.currency
  end

  private

  def health_params
    params.require(:health).permit(:category, :date_of_purchase, :amount, :shop_name, :description)
  end
end
