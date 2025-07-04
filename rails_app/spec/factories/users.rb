require 'faker'

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    sequence(:email) {|n| "user_#{n}@test.com"}
    password {'password123'}
    role { :general }

    trait :admin do
      role { :admin }
    end

    trait :editor do
      role { :editor }
    end
  end
end
