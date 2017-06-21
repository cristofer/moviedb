require 'rails_helper'

RSpec.feature "Users can comment on movies" do
  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:movie) { FactoryGirl.create(:movie, user: user) }

  before do
    login_as(user)
  end

  scenario "with valid attributes", js: true do
    visit movie_path(movie)
    fill_in "Comment", with: "Added a comment"

    click_button "Create Comment"

    expect(page).to have_content "Added a comment"
  end

  scenario "with invalid attributes" do
    visit movie_path(movie)
    click_button "Create Comment"

    expect(page).to have_content "Comment Text can't be blank"
  end
end
