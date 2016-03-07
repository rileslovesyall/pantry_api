class AddExpInfoToUsers < ActiveRecord::Migration
  def change
    add_column(:users, :exp_notif, :boolean, :default => true)
    add_column(:users, :exp_soon_days, :integer, :default => 14)
    add_column(:pantry_items, :days_to_exp, :string)
  end
end
