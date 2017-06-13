require 'rails_helper'

RSpec.feature "Users can search for movies" do
#Capybara.default_max_wait_time = 5

  let(:user) { FactoryGirl.create :user }
  let!(:movie1) { FactoryGirl.create(:movie, title: "Test Movie 1") }
  let!(:movie2) { FactoryGirl.create(:movie, title: "Test Movie 2") }

  before do
    login_as(user)
    visit "/"
  end

  scenario "with text", js: true do
    fill_in "search", with: "Test Movie 1"
    click_button "search"

    expect(page).to have_content "Test Movie 1"
    expect(page).not_to have_content "Test Movie 2"
  end
end
