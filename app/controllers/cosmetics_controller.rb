class CosmeticsController < ApplicationController
  def index
    @cosmetic = Cosmetic.new
    @cosmetics = Cosmetic.all
    @cosmetics = Cosmetic.order(date_of_purchase: :desc).limit(6)
    current_month = Time.now.month
    current_year = Time.now.year
    @beginning_of_month = Time.new(current_year, current_month, 1)
    @end_of_month = (@beginning_of_month + 1.month) - 1
  end

  def create
    @cosmetic = Cosmetic.new(cosmetic_params)
    @cosmetic.user = current_user
    @cosmetics = Cosmetic.all
    @cosmetics = Cosmetic.order(date_of_purchase: :desc).limit(6)
    # if @cosmetic.save
    #   flash.notice = "Expense created successfully"
    #   redirect_to cosmetics_path
    # else
    #   flash.alert = "Expense not created. Fulfill all the required fields!"
    # end

    respond_to do |format|
      if @cosmetic.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_cosmetic',
                                partial: 'form',
                                locals: { cosmetic: Cosmetic.new, cosmetics: Cosmetic.all }),
            turbo_stream.update('cosmetics',
                                partial: 'cosmetic',
                                locals: { cosmetic: @cosmetic, cosmetics: @cosmetics })]
        end
        format.html { redirect_to cosmetics_path, notice: "Expense created successfully" }
      else
        format.turbo_stream do
          render turbo_stream: [turbo_stream.update('new_cosmetic', partial: "form", locals: {cosmetic: @cosmetic})]
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def filter
    @cosmetics = []
    if params[:query].present? && params[:date_from].present? && params[:date_to].present?
      @cosmetics = Cosmetic.all
      @cosmetics = @cosmetics.where(['category = ? AND date_of_purchase >= ? AND date_of_purchase <= ?', params[:query], params[:date_from], params[:date_to]]).order(:date_of_purchase)
      @total = total
    elsif params[:query].present? && params[:date_from].present?
      @cosmetics = Cosmetic.all
      @cosmetics = @cosmetics.where('category = ? AND date_of_purchase >= ?', params[:query], params[:date_from]).order(:date_of_purchase)
      @total = total
    elsif params[:query].present? && params[:date_to].present?
      @cosmetics = Cosmetic.all
      @cosmetics = @cosmetics.where('category = ? AND date_of_purchase <= ?', params[:query], params[:date_to]).order(:date_of_purchase)
      @total = total
    elsif params[:date_from].present? && params[:date_to].present?
      @cosmetics = Cosmetic.all
      @cosmetics = @cosmetics.where(['date_of_purchase >= ? AND date_of_purchase <= ?', params[:date_from], params[:date_to]]).order(:date_of_purchase)
      @total = total
    elsif params[:date_from].present?
      @cosmetics = Cosmetic.all
      @cosmetics = @cosmetics.where('date_of_purchase >= ?', params[:date_from]).order(:date_of_purchase)
      @total = total
    elsif params[:date_to].present?
      @cosmetics = Cosmetic.all
      @cosmetics = @cosmetics.where('date_of_purchase <= ?', params[:date_to]).order(:date_of_purchase)
      @total = total
    else
      @cosmetics = Cosmetic.all
      @cosmetics = @cosmetics.where('category = ?', params[:query]).order(:date_of_purchase)
      @total = total
    end
  end

  def total
    @cosmetics.sum(:amount)
  end

  private

  def cosmetic_params
    params.require(:cosmetic).permit(:category, :date_of_purchase, :amount, :shop_name, :description)
  end
end
