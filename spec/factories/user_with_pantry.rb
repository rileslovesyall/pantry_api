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
  end

  factory :pi2, class: PantryItem do
    
  end

  factory :pi3, class: PantryItem do
    
  end

  factory :pi4, class: PantryItem do
    
  end

end