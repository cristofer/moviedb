require 'rails_helper'

RSpec.feature "Users can view movies" do
  scenario "with the movie details" do
    movie = FactoryGirl.create(:movie, title: "Movie 1", text: "Text Movie 1")

    visit "/"
    click_link "Movie 1"
    expect(page.current_url).to eq movie_url(movie)
  end
end
