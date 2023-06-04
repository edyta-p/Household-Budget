class Repayment < ApplicationRecord
  belongs_to :user

  CATEGORY = ['Credits', 'Mortgage', 'Loans', 'Other']
  CATEGORIES = CATEGORY.unshift(' ')
  validates :category, presence: true, inclusion: { in: CATEGORY }
  validates :date_of_transaction, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
