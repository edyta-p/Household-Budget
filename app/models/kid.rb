class Kid < ApplicationRecord
  belongs_to :user

  CATEGORY = ['Toys', 'School supplies', 'Additional classes', 'Tuition', 'Babysitter', 'Other']

  validates :category, presence: true, inclusion: { in: CATEGORY }
  validates :date_of_purchase, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
