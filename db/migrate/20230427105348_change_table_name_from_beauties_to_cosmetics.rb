class ChangeTableNameFromBeautiesToCosmetics < ActiveRecord::Migration[7.0]
  def change
      rename_table :beauties, :cosmetics
  end
end
