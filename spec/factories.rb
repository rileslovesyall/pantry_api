FactoryGirl.define do
  
  factory :pantry_item, class: PantryItem do
    name "Pickled Parakeets"
    quantity 3
    user_id 3
  end

  factory :user do
    name "Riley"
    email "abc@abc.com"
  end

end