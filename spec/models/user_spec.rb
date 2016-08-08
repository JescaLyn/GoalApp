require 'rails_helper'

RSpec.describe User, type: :model do
  FactoryGirl.create(:user)

  describe "User create" do
    it "encrypts password" do
      user = User.first
      expect(user.password_digest).not_to eq(nil)
      expect(user.password).to eq(nil)
    end

    it "encrypts using BCrypt" do
      expect(BCrypt::Password).to receive(:create)
      FactoryGirl.create(:user)
    end

    it "requires password to be at least six characters" do
      user = FactoryGirl.build(:user_short_password)
      expect(user.is_valid?).to be_falsy
    end
  end

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it { should validate_uniqueness_of(:session_token) }
  it { should validate_uniqueness_of(:username) }
end
