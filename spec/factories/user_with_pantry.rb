FactoryGirl.define do

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