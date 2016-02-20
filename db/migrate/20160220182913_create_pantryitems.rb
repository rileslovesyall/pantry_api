class CreatePantryitems < ActiveRecord::Migration
  def change
    create_table :pantry_items do |t|
      t.string :name
      t.text :description
      t.integer :quantity
      t.integer :user_id
    end
  end
end
