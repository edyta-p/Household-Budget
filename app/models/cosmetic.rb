class Cosmetic < ApplicationRecord
  belongs_to :user

  CATEGORY = ['Cosmetics', 'Cleaning products', 'Hairdresser', 'Beauty treatments', 'Contact lenses', 'Hair accessories', 'Other']

  validates :category, presence: true, inclusion: { in: CATEGORY }
  validates :date_of_purchase, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
