class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home start]

  def home
  end

  def start
    @categories = ['Meal', 'Apartment', 'Car', 'Mobile and Internet', 'Health', 'Clothing', 'Beauty and hygiene', 'Kids', 'Entertainment and holidays', 'Other', 'Repayment of debts', 'Savings' ]
  end
end
