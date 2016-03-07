class AddExpInfoToUsers < ActiveRecord::Migration
  def change
    add_column(:users, :exp_notif, :boolean, :default => true)
    add_column(:users, :exp_time, :integer, :default => 14)
    add_column(:pantry_item_users, :exp_date, :string)
    remove_column(:pantry_items, :expiration_date)
    add_column(:pantry_items, :days_to_exp, :string)
  end
end
