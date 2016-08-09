module GoalFeaturesHelper
  def submit_new_goal(title)
    visit new_goal_url
    fill_in "Title", with: title
    click_button "Create Goal"
  end

  def build_three_goals
    submit_new_goal("Juggle Monkeys")
    submit_new_goal("Eat Fire")
    submit_new_goal("Wash Elephant")
  end

  def verify_three_goals
    expect(page).to have_content("Juggle Monkeys")
    expect(page).to have_content("Eat Fire")
    expect(page).to have_content("Wash Elephant")
  end
end
