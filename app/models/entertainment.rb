class Entertainment < ApplicationRecord
  belongs_to :user

  CATEGORY = ['Gym', 'Yoga', 'Swimming pool', 'Cinema', 'Theater', 'Concert', 'Book', 'Magazine', 'Hobby', 'Hotel', 'Netflix/Amazon Prime', 'Other']
  CATEGORIES = CATEGORY.unshift(' ')
  validates :category, presence: true, inclusion: { in: CATEGORY }
  validates :date_of_purchase, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
