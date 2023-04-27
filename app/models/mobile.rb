class Mobile < ApplicationRecord
  belongs_to :user

  CATEGORY = ['Phone1', 'Phone2', 'Internet', 'TV', 'Other']

  validates :category, presence: true, inclusion: { in: CATEGORY }
  validates :date_of_purchase, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
