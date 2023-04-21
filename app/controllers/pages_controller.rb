class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home]

  def home
  end

  def start
    @categories = [
      { name: 'Meal', description: 'random description', display: 'Meals' },
      { name: 'Apartment', description: 'random description', display: 'Apartment' },
      { name: 'Car', description: 'random description', display: 'Car' },
      { name: 'Beauty', description: 'random description', display: 'Beauty and hygiene' },
      { name: 'Entertainment', description: 'random description', display: 'Entertainment and holidays' },
      { name: 'Mobile', description: 'random description', display: 'Mobile and Internet' },
      { name: 'Health', description: 'random description', display: 'Health' },
      { name: 'Clothing', description: 'random description', display: 'Clothing' },
      { name: 'Kid', description: 'random description', display: 'Kids' },
      { name: 'Other', description: 'random description', display: 'Other' },
      { name: 'Repayment', description: 'random description', display: 'Repayment of debts' },
      { name: 'Saving', description: 'random description', display: 'Savings' }
    ]
  end
end
