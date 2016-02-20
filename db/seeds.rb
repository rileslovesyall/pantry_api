users = [{name: "Riles", email: "xyz@gmail.com"}]

pantry_items = [{name: "Applesauce", description: "Just like mama used to make.", user_id: 1}]

users.each do |user|
  User.create(user)
end

pantry_items.each do |pi|
  PantryItem.create(pi)
end