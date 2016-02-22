class AddExpirationDatePantryItem < ActiveRecord::Migration
  def change
    add_column(:pantry_items, :expiration_date, :string)
  end
end
