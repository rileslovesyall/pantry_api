class RemoveExpDateFromPantryItems < ActiveRecord::Migration
  def change
    remove_column(:pantry_items, :expiration_date)
  end
end
