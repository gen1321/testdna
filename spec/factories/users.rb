FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    middle_name { Faker::LeagueOfLegends.champion }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    city { Faker::Address.city }

    trait :admin do
      admin true
    end

    trait :waiting_for_approve do
      status 'waiting_for_approve'
    end

    trait :approved do
      status 'approved'
    end

    trait :approved_soc do
      status 'approved_soc'
    end

    trait :declined do
      status 'declined'
    end

    trait :banned do
      status 'banned'
      banned_at Time.zone.now
    end
  end
end
