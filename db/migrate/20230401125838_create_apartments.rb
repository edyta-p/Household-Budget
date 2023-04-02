class CreateApartments < ActiveRecord::Migration[7.0]
  def change
    create_table :apartments do |t|
      t.string :category
      t.float :amount
      t.string :currency, default: '€', null: false
      t.datetime :date_of_purchase
      t.string :shop_name
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
