class Apartment < ApplicationRecord
  belongs_to :user
  CATEGORY = ['rent', 'water', 'electricity', 'heating', 'garbage disposal', 'reparation', 'equipment', 'furniture', 'decoration', 'other']

  validates :category, presence: true, inclusion: { in: CATEGORY }
  validates :date_of_purchase, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
