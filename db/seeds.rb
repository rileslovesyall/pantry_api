users = [
  {name: "Rick", email: "rick@tinyrick.com", password: "123", password_confirmation: "123", api_token: "pantryz0GH_fEfLryZxoo0OS0kkw"},
  {name: "Morty", email: "morty@tinyrick.com", password: "123", password_confirmation: "123"},
  {name: "Bird Person", email: "bird@person.com", password: "123", password_confirmation: "123"}
]

pantry_items = [
  {name: "Applesauce", description: "Just like mama used to make.", portion_size: "Quart" , quantity: 3, user_id: 1, expiration_date: (DateTime.now + 3)},
  {name: "Cucumber Pickles", description: "Dill.", portion_size: "Half Gallon", quantity: 2, user_id: 1, expiration_date: (DateTime.now + 2)},
  {name: "Tomato Soup", description: "Get dat grilled cheese on.", portion_size: "Quart", quantity: 4, user_id: 1, expiration_date: (DateTime.now + 6)},
  {name: "Old Fashioned Pickles", portion_size: "Pint", quantity: 45, user_id: 2, expiration_date: (DateTime.now + 3)},
  {name: "Pickled Asparagus", quantity: 15, portion_size: "8 oz", user_id: 2, expiration_date: (DateTime.now + 3)}
]

categories = [
  {name: "Pickles"},
  {name: "Fruit"}
]

pantry_item_categories = [
  {pantry_item_id: 1, category_id: 2},
  {pantry_item_id: 2, category_id: 1},
  {pantry_item_id: 4, category_id: 1},
  {pantry_item_id: 5, category_id: 1}
]

ingredients = [
  {name: "Apples"},
  {name: "Cucumbers"},
  {name: "Salt"},
  {name: "Sugar"},
  {name: "Asparagus"},
  {name: "White Vinegar"}
]

pantry_item_ingredients = [
  {ingredient_id: 1,pantry_item_id: 1},
  {ingredient_id: 4,pantry_item_id: 1},
  {ingredient_id: 2,pantry_item_id: 2},
  {ingredient_id: 3,pantry_item_id: 2},
  {ingredient_id: 5,pantry_item_id: 5},
  {ingredient_id: 6,pantry_item_id: 5}
]


users.each do |u|
  User.create(u)
end

pantry_items.each do |p|
  PantryItem.create(p)
end

categories.each do |c|
  Category.create(c)
end

pantry_item_categories.each do |pc|
  PantryItemCategory.create(pc)
end

ingredients.each do |i|
  Ingredient.create(i)
end

pantry_item_ingredients.each do |pii|
  PantryItemIngredient.create(pii)
end
