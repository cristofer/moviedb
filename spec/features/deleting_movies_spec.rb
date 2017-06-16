require "rails_helper"

RSpec.feature "Users can delete movies" do
  let(:user) { FactoryGirl.create(:user) }

  before do
    login_as(user)
  end

  scenario "inside the movie" do
    movie = FactoryGirl.create(:movie, user: user)

    visit "/"
    click_link "Movie 1"
    click_link "Delete Movie"

    expect(page).to have_no_content "Movie 1"
  end

  scenario "in index", js: true do
    movie = FactoryGirl.create(:movie, title: 'Movie 2', user: user)

    visit "/"
    click_link "Delete Movie"
    page.driver.browser.switch_to.alert.accept

    expect(page).to have_no_content "Movie 2"
  end
end
