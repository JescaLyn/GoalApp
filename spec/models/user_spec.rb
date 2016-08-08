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

require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    FactoryGirl.create(:user)
  end

  describe "User create" do
    it "encrypts password" do
      user = User.first
      expect(user.password_digest).not_to eq(nil)
      expect(user.password).to eq(nil)
    end

    it "encrypts using BCrypt" do
      expect(BCrypt::Password).to receive(:create)
      FactoryGirl.build(:user).save
    end

    it "requires password to be at least six characters" do
      user = FactoryGirl.build(:user_short_password)
      expect(user.valid?).to be_falsy
    end
  end

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it { should validate_uniqueness_of(:session_token) }
  it { should validate_uniqueness_of(:username) }

  describe "User::find_by_credentials" do
    subject(:user) { User.new(username: "happygolucky", password: "itsallalie") }
    before :each do
      user.save!
    end

    it "finds the right user" do
      expect(User.find_by_credentials("happygolucky", "itsallalie")).to eq(user)
    end
    it "doesn't find the user without the correct password" do
      expect(User.find_by_credentials("happygolucky", "WRONG")).to eq(nil)
    end
  end
end
