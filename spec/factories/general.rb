FactoryGirl.define do
  
  factory :user do
    name "Rick"
    email "rick@tinyrick.com"
    password "123"
    password_confirmation "123"
  end

  factory :user1, class: User do
    name "Beth"
    email "horse@surgeon.com"
    password "123"
    password_confirmation "123"
  end

  factory :user2, class: User do
    name "Jerry"
    email "jerry@cloudatlas.com"
    password "123"
    password_confirmation "123"
  end

  factory :pantry_item, class: PantryItem do
    name "Pickled Parakeets"
    quantity 3
    portion "Quart"
    days_to_exp 15
    association :user, factory: :user1, strategy: :build
  end

  factory :category do
    name "Pickles"
  end

  factory :ingredient do
    name "Salt"
  end

  factory :piul_add, class: PantryItemsUserLog do
    association :user, strategy: :build
    pantry_item
    action "add"
    quantity 1
  end

  factory :piul_consume, class: PantryItemsUserLog do
    association :user, factory: :user1, strategy: :build
    pantry_item
    action "consume"
    quantity 1
  end

  factory :full_pantry_user, class: User do
    name "Bird Person"
    email "berd@person.com"
    password "123"
    password_confirmation "123"
  end

  factory :pi1, class: PantryItem do
    name "Pickled Eggs"
    quantity 4
    portion 'Cup'
    days_to_exp 16
    association :user, factory: :full_pantry_user
  end

  factory :pi2, class: PantryItem do
    name "Eye Holes"
    quantity 15
    portion 'Hole'
    days_to_exp 4
    association :user, factory: :full_pantry_user, email: "123@3.com"
  end

  factory :pi3, class: PantryItem do
    name "Strawberry Smiggles"
    quantity 9
    portion 'Bowl'
    days_to_exp 25
    show_public false
    association :user, factory: :full_pantry_user, email: "Strawberry@Smiggles.com"
  end

  factory :pi4, class: PantryItem do
    name "Turbulent Juice"
    quantity 9
    portion 'Tube'
    days_to_exp 100
    show_public true
    association :user, factory: :full_pantry_user, email: "thing@one.com"
  end

end