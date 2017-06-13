require 'rails_helper'

RSpec.feature "users can see the list of movies" do
  let(:user) { FactoryGirl.create(:user) }
  let!(:movie) { FactoryGirl.create(:movie, title: "Movie 1", user: user) }

  scenario "anonymous users" do
    visit "/"

    expect(page).to have_content "Movie 1"
  end
end
