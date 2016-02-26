class ChangeWhereConsumedActionIsRecorded < ActiveRecord::Migration
  def change
    remove_column(:pantry_items, :consumed)
    remove_column(:pantry_items, :consumed_at)
    create_table :pantry_item_users do |t|
      t.integer :user_id
      t.integer :pantry_item_id
      t.string :action 
      t.integer :quantity
    end
  end
end
