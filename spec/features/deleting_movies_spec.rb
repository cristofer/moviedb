require "rails_helper"

RSpec.feature "Users can delete movies" do
  let(:user) { FactoryGirl.create(:user) }

  before do
    login_as(user)
  end

  scenario "successfully" do
    movie = FactoryGirl.create(:movie, user: user)

    visit "/"
    click_link "Movie 1"
    click_link "Delete Movie"

    expect(page).to have_content "Movie has been deleted."
    expect(page.current_url).to eq movies_url
    expect(page).to have_no_content "Movie 1"
  end
end
