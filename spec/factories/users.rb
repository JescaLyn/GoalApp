# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

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
