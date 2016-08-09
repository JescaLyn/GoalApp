require 'rails_helper'

feature "CRUD of goals" do
  let(:user) { FactoryGirl.create(:user) }

  before :each do
    login_as(user.username)
  end

  feature "creating goals" do
    it "should have a create goal page" do
      visit new_goal_url
      expect(page).to have_content("New Goal")
    end

    it "should show the new goal" do
      submit_new_goal("This is a goal")
      expect(page).to have_content("This is a goal")
    end
  end

  feature "showing goals" do
    it "should list goals" do
      build_three_goals
      visit user_url(user)
      verify_three_goals
    end
  end

  feature "updating goals" do
    it "updates the completion status" do
      submit_new_goal("take a nap")
      click_button("Complete")
      expect(page).to have_content("Completed")
      click_button("Oops, Not Completed")
      expect(page).to_not have_content("Completed")
    end
  end

  feature "destroy goals" do
    it "destroys a goal" do
      submit_new_goal("get a job")
      click_button("Delete Goal (I give up)")
      expect(page).to have_content("#{user.username}'s Goals'")
    end
  end
end
