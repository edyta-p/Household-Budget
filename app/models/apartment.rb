class Apartment < ApplicationRecord
  belongs_to :user
  CATEGORY = ['Rent', 'Water', 'Electricity', 'Heating', 'Garbage disposal', 'Reparation', 'Equipment', 'Furniture', 'Decoration', 'Other']
  CATEGORIES = CATEGORY.unshift(' ')
  validates :category, presence: true, inclusion: { in: CATEGORY }
  validates :date_of_purchase, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
