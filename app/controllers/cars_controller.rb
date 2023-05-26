# class CarsController < ApplicationController
#   def index
#     @car = Car.new
#     @cars = Car.all
#   end

#   def create
#     @car = Car.new(car_params)
#     @car.user = current_user
#     @car.save!
#     redirect_to root_path
#   end

#   private

#   def car_params
#     params.require(:car).permit(:category, :date_of_purchase, :amount)
#   end
# end
class CarsController < ApplicationController
  def index
    @car = Car.new
    @cars = Car.all
    @cars = Car.order(date_of_purchase: :desc).limit(6)
  end

  def create
    @car = Car.new(car_params)
    @car.user = current_user
    @cars = Car.all
    @cars = Car.order(date_of_purchase: :desc).limit(6)
    # if @car.save
    #   flash.notice = "Expense created successfully"
    #   redirect_to cars_path
    # else
    #   flash.alert = "Expense not created. Fulfill all the required fields!"
    # end

    respond_to do |format|
      if @car.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_car',
                                partial: 'form',
                                locals: { car: Car.new, cars: Car.all }),
            turbo_stream.update('cars',
                                partial: 'car',
                                locals: { car: @car, cars: @cars })]
        end
        format.html { redirect_to cars_path, notice: "Expense created successfully" }
      else
        format.turbo_stream do
          render turbo_stream: [turbo_stream.update('new_car', partial: "form", locals: {car: @car})]
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def filter
    @cars = []
    if params[:query].present?
      @cars = Car.all
      @cars = @cars.where(category: params[:query]).order(:date_of_purchase)
    end
  end

  private

  def car_params
    params.require(:car).permit(:category, :date_of_purchase, :amount, :shop_name, :description)
  end
end
