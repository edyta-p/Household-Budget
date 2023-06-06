class MobilesController < ApplicationController
  def index
    @mobile = Mobile.new
    @mobiles = Mobile.all
    @mobiles = Mobile.order(date_of_purchase: :desc).limit(6)
    current_month = Time.now.month
    current_year = Time.now.year
    @beginning_of_month = Time.new(current_year, current_month, 1)
    @end_of_month = (@beginning_of_month + 1.month) - 1
  end

  def create
    @mobile = Mobile.new(mobile_params)
    @mobile.user = current_user
    @mobiles = Mobile.all
    @mobiles = Mobile.order(date_of_purchase: :desc).limit(6)
    # if @mobile.save
    #   flash.notice = "Expense created successfully"
    #   redirect_to mobiles_path
    # else
    #   flash.alert = "Expense not created. Fulfill all the required fields!"
    # end

    respond_to do |format|
      if @mobile.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_mobile',
                                partial: 'form',
                                locals: { mobile: Mobile.new, mobiles: Mobile.all }),
            turbo_stream.update('mobiles',
                                partial: 'mobile',
                                locals: { mobile: @mobile, mobiles: @mobiles })]
        end
        format.html { redirect_to mobiles_path, notice: "Expense created successfully" }
      else
        format.turbo_stream do
          render turbo_stream: [turbo_stream.update('new_mobile', partial: "form", locals: {mobile: @mobile})]
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def filter
    @mobiles = []
    if params[:query].present? && params[:date_from].present? && params[:date_to].present?
      @mobiles = Mobile.all
      @mobiles = @mobiles.where(['category = ? AND date_of_purchase >= ? AND date_of_purchase <= ?', params[:query], params[:date_from], params[:date_to]]).order(:date_of_purchase)
      @total = total
    elsif params[:query].present? && params[:date_from].present?
      @mobiles = Mobile.all
      @mobiles = @mobiles.where('category = ? AND date_of_purchase >= ?', params[:query], params[:date_from]).order(:date_of_purchase)
      @total = total
    elsif params[:query].present? && params[:date_to].present?
      @mobiles = Mobile.all
      @mobiles = @mobiles.where('category = ? AND date_of_purchase <= ?', params[:query], params[:date_to]).order(:date_of_purchase)
      @total = total
    elsif params[:date_from].present? && params[:date_to].present?
      @mobiles = Mobile.all
      @mobiles = @mobiles.where(['date_of_purchase >= ? AND date_of_purchase <= ?', params[:date_from], params[:date_to]]).order(:date_of_purchase)
      @total = total
    elsif params[:date_from].present?
      @mobiles = Mobile.all
      @mobiles = @mobiles.where('date_of_purchase >= ?', params[:date_from]).order(:date_of_purchase)
      @total = total
    elsif params[:date_to].present?
      @mobiles = Mobile.all
      @mobiles = @mobiles.where('date_of_purchase <= ?', params[:date_to]).order(:date_of_purchase)
      @total = total
    else
      @mobiles = Mobile.all
      @mobiles = @mobiles.where('category = ?', params[:query]).order(:date_of_purchase)
      @total = total
    end
  end

  def total
    @mobiles.sum(:amount)
  end

  private

  def mobile_params
    params.require(:mobile).permit(:category, :date_of_purchase, :amount, :shop_name, :description)
  end
end
