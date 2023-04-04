class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home]

  def home
  end

  def start
    @categories = [
      { name: 'Meal', description: 'random description' },
      { name: 'Apartment', description: 'random description' },
      { name: 'Car', description: 'random description' },
      { name: 'Mobile and Internet', description: 'random description' },
      { name: 'Health', description: 'random description' },
      { name: 'Clothing', description: 'random description' },
      { name: 'Beauty and hygiene', description: 'random description' },
      { name: 'Kids', description: 'random description' },
      { name: 'Entertainment and holidays', description: 'random description' },
      { name: 'Other', description: 'random description' },
      { name: 'Repayment of debts', description: 'random description' },
      { name: 'Savings', description: 'random description' }
    ]
  end
end
