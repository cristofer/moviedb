require 'rails_helper'

RSpec.feature "Any user can search for movies" do
#Capybara.default_max_wait_time = 5

  let(:user) { FactoryGirl.create :user }
  let(:category1) { FactoryGirl.create(:category, name: "Category 1") }
  let(:category2) { FactoryGirl.create(:category, name: "Category 2") }
  let!(:movie1) { FactoryGirl.create(:movie, title: "Test Movie 1") }
  let!(:movie2) { FactoryGirl.create(:movie, title: "Test Movie 2") }
  let!(:rating) { FactoryGirl.create(:rating, user: user, movie: movie1, stars: 5) }

  before do
    movie1.categories << category1
    movie2.categories << category2

    visit "/"
  end

  scenario "with text", js: true do
    fill_in "search", with: "Test Movie 1"
    click_button "search"

    expect(page).to have_content "Test Movie 1"
    expect(page).not_to have_content "Test Movie 2"
  end

  scenario "selecting a category", js: true do
    click_link "Category 1"

    expect(page).to have_content "Test Movie 1"
    expect(page).not_to have_content "Test Movie 2"
  end

  scenario "selecting stars", js: true do
    click_link "5 Stars (1)"

    expect(page).to have_content "Test Movie 1"
    expect(page).not_to have_content "Test Movie 2"
  end
end
