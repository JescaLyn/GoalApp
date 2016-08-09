require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Register"
  end

  feature "signing up a user" do
    before :each do
      register_as("jon")
    end

    scenario "shows username on the homepage after signup" do
      expect(page).to have_content "jon"
    end
  end
end

feature "logging in" do
  before :each do
    User.create!(username: "jon", password: "password")
    login_as("jon")
  end

  scenario "shows username on the homepage after login" do
    expect(page).to have_content "jon"
  end

  scenario "redirects away from signin if user is logged in" do
    visit new_session_url
    expect(page).to_not have_content("Login")
  end
end

feature "logging out" do
  scenario "begins with a logged out state" do
    visit new_session_url
    expect(page).to have_content "Login"
  end

  scenario "doesn't show username on the homepage after logout" do
    User.create!(username: "jon", password: "password")
    login_as("jon")
    click_on "Logout"
    expect(page).to_not have_content("jon")
  end

end
