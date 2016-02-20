class Createpantryitemscategories < ActiveRecord::Migration
  def change
    create_table :pantry_item_categories do |t|
      t.integer :pantry_item_id
      t.integer :category_id
    end
  end
end
