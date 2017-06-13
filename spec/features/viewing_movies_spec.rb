require 'rails_helper'

RSpec.feature "Users can view movies" do
  let(:user) { FactoryGirl.create(:user) }
  let!(:movie) { FactoryGirl.create(:movie, title: "Movie 1", text: "Text Movie 1") }

  scenario "with the movie details" do
    login_as(user)

    visit "/"
    click_link "Movie 1"
    expect(page.current_url).to eq movie_url(movie)
  end
end
