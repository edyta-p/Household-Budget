class MealsController < ApplicationController
  def index
    @meal = Meal.new
    @meals = Meal.all
    @meals = Meal.order(date_of_purchase: :desc).limit(6)
    current_month = Time.now.month
    current_year = Time.now.year
    @beginning_of_month = Time.new(current_year, current_month, 1)
    @end_of_month = (@beginning_of_month + 1.month) - 1
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.user = current_user
    @meals = Meal.all
    @meals = Meal.order(date_of_purchase: :desc).limit(6)
    # if @meal.save
    #   flash.notice = "Expense created successfully"
    #   redirect_to meals_path
    # else
    #   flash.alert = "Expense not created. Fulfill all the required fields!"
    # end

    respond_to do |format|
      if @meal.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_meal',
                                partial: 'form',
                                locals: { meal: Meal.new, meals: Meal.all }),
            turbo_stream.update('meals',
                                partial: 'meal',
                                locals: { meal: @meal, meals: @meals })]
        end
        format.html { redirect_to meals_path, notice: "Expense created successfully" }
      else
        format.turbo_stream do
          render turbo_stream: [turbo_stream.update('new_meal', partial: "form", locals: {meal: @meal})]
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def filter
    @meals = []
    if params[:query].present? && params[:date_from].present? && params[:date_to].present?
      @meals = Meal.all
      @meals = @meals.where(['category = ? AND date_of_purchase >= ? AND date_of_purchase <= ?', params[:query], params[:date_from], params[:date_to]]).order(:date_of_purchase)
      @total = total
    elsif params[:query].present? && params[:date_from].present?
      @meals = Meal.all
      @meals = @meals.where('category = ? AND date_of_purchase >= ?', params[:query], params[:date_from]).order(:date_of_purchase)
      @total = total
    elsif params[:query].present? && params[:date_to].present?
      @meals = Meal.all
      @meals = @meals.where('category = ? AND date_of_purchase <= ?', params[:query], params[:date_to]).order(:date_of_purchase)
      @total = total
    elsif params[:date_from].present? && params[:date_to].present?
      @meals = Meal.all
      @meals = @meals.where(['date_of_purchase >= ? AND date_of_purchase <= ?', params[:date_from], params[:date_to]]).order(:date_of_purchase)
      @total = total
    elsif params[:date_from].present?
      @meals = Meal.all
      @meals = @meals.where('date_of_purchase >= ?', params[:date_from]).order(:date_of_purchase)
      @total = total
    elsif params[:date_to].present?
      @meals = Meal.all
      @meals = @meals.where('date_of_purchase <= ?', params[:date_to]).order(:date_of_purchase)
      @total = total
    else
      @meals = Meal.all
      @meals = @meals.where('category = ?', params[:query]).order(:date_of_purchase)
      @total = total
    end
  end

  def total
    @meals.sum(:amount)
  end

  private

  def meal_params
    params.require(:meal).permit(:category, :date_of_purchase, :amount, :shop_name, :description)
  end
end
