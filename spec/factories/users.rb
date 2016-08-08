FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name }
    password { Faker::Internet.password }

    factory :user_no_username do
      username nil
    end

    factory :user_short_password do
      password "pass"
    end

    factory :nil_password do
      password nil
    end
  end
end
