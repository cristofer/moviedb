require "rails_helper"

RSpec.feature "Users can create new movies" do
  scenario "with valid attributes" do
    visit "/"

    click_link "New Movie"

    fill_in "Title", with: "Movie 1"
    fill_in "Text", with: "Text for the Movie 1"

    click_button "Create Movie"

    expect(page).to have_content "Movie has been created."
  end  
end
