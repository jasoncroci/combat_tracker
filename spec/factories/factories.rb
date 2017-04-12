FactoryGirl.define do
  factory :user do
    email "user@user.com"
    before(:create) { |user| user.password = "Password" }
    factory :admin do
      admin true
    end
  end

  factory :character do
    name "Character"
    hit_points 100
    armor_class 20
  end

  factory :encounter do
    name "Encounter"
    challenge_rating 10
    experience_points 1000
    association :user, strategy: :build
  end

  factory :enemy do
    name "Enemy"
    hit_points 200
    armor_class 12
    initiative_bonus 0
    encounter
  end

  factory :combat do
    association :user
    association :encounter, strategy: :build
    data {
      {"encounter" => {"name" => "#{encounter.name}"}}
    }

  end
end
