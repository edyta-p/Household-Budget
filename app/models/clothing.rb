class Clothing < ApplicationRecord
  belongs_to :user

  CATEGORY = ['Clothes', 'Clothes for sport', 'Shoes', 'Accessories', 'Other']
  CATEGORIES = CATEGORY.unshift(' ')
  validates :category, presence: true, inclusion: { in: CATEGORY }
  validates :date_of_purchase, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
