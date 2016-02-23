users = [
  {name: "Rick", email: "rick@tinyrick.com", password: "newsgoes", password_confirmation: "newsgoes"},
  {name: "Morty", email: "morty@gmail.com", password: "morty1", password_confirmation: "morty1"},
  {name: "Bird Person", email: "bird@person.com", password: "monotone", password_confirmation: "monotone"}
]

pantry_items = [
  {name: "Applesauce", description: "Just like mama used to make.", quantity: 3, user_id: 1, expiration_date: (DateTime.now + 3)},
  {name: "Cucumber Pickles", description: "Dill.", quantity: 2, user_id: 1, expiration_date: (DateTime.now + 2)},
  {name: "Tomato Soup", description: "Get dat grilled cheese on.", quantity: 4, user_id: 1, expiration_date: (DateTime.now + 6)},
  {name: "Old Fashioned Pickes", quantity: 45, user_id: 2, expiration_date: (DateTime.now + 3)},
  {name: "Pickled Asparagus", quantity: 15, user_id: 2, expiration_date: (DateTime.now + 3)}
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

recipes = [
  {name: "Gran's Old Applesauce", user_id: 2},
  {name: "Dilly 'Sparagus Pickles", user_id: 1}
]

recipe_ingredients = [
  {recipe_id: 1, ingredient_id: 1},
  {recipe_id: 1, ingredient_id: 4},
  {recipe_id: 2, ingredient_id: 5},
  {recipe_id: 2, ingredient_id: 6},
  {recipe_id: 2, ingredient_id: 2}
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

recipes.each do |r|
  Recipe.create(r)
end

recipe_ingredients.each do |ri|
  RecipeIngredient.create(ri)
end