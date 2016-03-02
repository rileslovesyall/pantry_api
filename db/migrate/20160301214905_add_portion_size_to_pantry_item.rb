class AddPortionSizeToPantryItem < ActiveRecord::Migration
  def change
    add_column(:pantry_items, :portion, :string)
  end
end
