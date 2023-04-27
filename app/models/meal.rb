class Meal < ApplicationRecord
  belongs_to :user

  CATEGORY = ['Groceries', 'Eating out', 'Eating at work', 'Eating while travelling', 'Alcohol', 'Barbecues', 'Food for the pets', 'Other']

  validates :category, presence: true, inclusion: { in: CATEGORY }
  validates :date_of_purchase, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
