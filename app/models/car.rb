class Car < ApplicationRecord
  belongs_to :user

  CATEGORY = ['Fuel', 'Inspections and repairs', 'Additional equipment (e.g. tires)', 'Insurence', 'Public transport tickets', 'Train or bus ticket', 'Taxi', 'Motorway', 'Other']
  CATEGORIES = CATEGORY.unshift(' ')
  validates :category, presence: true, inclusion: { in: CATEGORY }
  validates :date_of_purchase, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
