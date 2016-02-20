users = [
  {name: "Rick", email: "thewaythenewsgoes@tinyrick.com"},
  {name: "Morty", email: "wubalubadubdub@gmail.com"},
  {name: "Bird Person", email: "serious@flat.com"}
]

pantry_items = [
  {name: "Applesauce", description: "Just like mama used to make.", quantity: 3, user_id: 1},
  {name: "Cucumber Pickles", description: "Dill.", quantity: 2, user_id: 1},
  {name: "Tomato Soup", description: "Get dat grilled cheese on.", quantity: 4, user_id: 1}
  {name: "Old Fashioned Pickes", quantity: 45, user_id: 2},
  {name: "Pickled Asparagus", quantity: 15, user_id: 2}
]

users.each do |u|
  User.create(u)
end

pantry_items.each do |p|
  PantryItem.create(p)
end