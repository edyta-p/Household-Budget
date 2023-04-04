class CreateSavings < ActiveRecord::Migration[7.0]
  def change
    create_table :savings do |t|
      t.string :category
      t.float :amount
      t.string :currency, default: "€", null: false
      t.datetime :date_of_transaction
      t.string :placement
      t.string :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
