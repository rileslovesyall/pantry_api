FactoryGirl.define do
  
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
    association :user, factory: :user1
  end

end