class Health < ApplicationRecord
  belongs_to :user

  CATEGORY = ['Medical visits', 'Tests', 'Medicaments', 'Insurance', 'Other']
  CATEGORIES = CATEGORY.unshift(' ')
  validates :category, presence: true, inclusion: { in: CATEGORY }
  validates :date_of_purchase, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
