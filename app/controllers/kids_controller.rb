class KidsController < ApplicationController
  def index
    @kid = Kid.new
    @kids = Kid.all
    @kids = Kid.order(date_of_purchase: :desc).limit(6)
    current_month = Time.now.month
    current_year = Time.now.year
    @beginning_of_month = Time.new(current_year, current_month, 1)
    @end_of_month = (@beginning_of_month + 1.month) - 1
  end

  def create
    @kid = Kid.new(kid_params)
    @kid.user = current_user
    @kids = Kid.all
    @kids = Kid.order(date_of_purchase: :desc).limit(6)
    # if @kid.save
    #   flash.notice = "Expense created successfully"
    #   redirect_to kids_path
    # else
    #   flash.alert = "Expense not created. Fulfill all the required fields!"
    # end

    respond_to do |format|
      if @kid.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_kid',
                                partial: 'form',
                                locals: { kid: Kid.new, kids: Kid.all }),
            turbo_stream.update('kids',
                                partial: 'kid',
                                locals: { kid: @kid, kids: @kids })]
        end
        format.html { redirect_to kids_path, notice: "Expense created successfully" }
      else
        format.turbo_stream do
          render turbo_stream: [turbo_stream.update('new_kid', partial: "form", locals: {kid: @kid})]
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def filter
    @kids = []
    if params[:query].present? && params[:date_from].present? && params[:date_to].present?
      @kids = Kid.all
      @kids = @kids.where(['category = ? AND date_of_purchase >= ? AND date_of_purchase <= ?', params[:query], params[:date_from], params[:date_to]]).order(:date_of_purchase)
      @total = total
    elsif params[:query].present? && params[:date_from].present?
      @kids = Kid.all
      @kids = @kids.where('category = ? AND date_of_purchase >= ?', params[:query], params[:date_from]).order(:date_of_purchase)
      @total = total
    elsif params[:query].present? && params[:date_to].present?
      @kids = Kid.all
      @kids = @kids.where('category = ? AND date_of_purchase <= ?', params[:query], params[:date_to]).order(:date_of_purchase)
      @total = total
    elsif params[:date_from].present? && params[:date_to].present?
      @kids = Kid.all
      @kids = @kids.where(['date_of_purchase >= ? AND date_of_purchase <= ?', params[:date_from], params[:date_to]]).order(:date_of_purchase)
      @total = total
    elsif params[:date_from].present?
      @kids = Kid.all
      @kids = @kids.where('date_of_purchase >= ?', params[:date_from]).order(:date_of_purchase)
      @total = total
    elsif params[:date_to].present?
      @kids = Kid.all
      @kids = @kids.where('date_of_purchase <= ?', params[:date_to]).order(:date_of_purchase)
      @total = total
    else
      @kids = Kid.all
      @kids = @kids.where('category = ?', params[:query]).order(:date_of_purchase)
      @total = total
    end
  end

  def total
    @kids.sum(:amount)
  end

  private

  def kid_params
    params.require(:kid).permit(:category, :date_of_purchase, :amount, :shop_name, :description)
  end
end
