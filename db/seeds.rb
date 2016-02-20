users = []

pantry_items = []

users.each do |user|
  User.create(user)
end

pantry_items.each do |pi|
  PantryItem.create(pi)
end