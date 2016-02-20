users = [{name: "Riles", email: "xyz@gmail.com"}]

pantry_items = [
  {name: "Applesauce", description: "Just like mama used to make.", quantity: 3, user_id: 1},
  {name: "Cucumber Pickles", description: "Dill.", quantity: 2, user_id: 1},
  {name: "Tomato Soup", description: "Get dat grilled cheese on.", quantity: 4, user_id: 1},
]

users.each do |user|
  User.create(user)
end

pantry_items.each do |pi|
  PantryItem.create(pi)
end