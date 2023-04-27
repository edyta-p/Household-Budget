class Other < ApplicationRecord
  belongs_to :user

  CATEGORY = ['Charity', 'Gifts', 'Home appliances', 'Education', 'Computer software', 'Services', 'Taxes', 'Bank fees', 'Post', 'Expenses at work', 'Other']

  validates :category, presence: true, inclusion: { in: CATEGORY }
  validates :date_of_purchase, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
