require "rails_helper"

RSpec.feature "Users can create new movies" do
  before do
    visit "/"

    click_link "New Movie"
  end

  scenario "with valid attributes" do
    fill_in "Title", with: "Movie 1"
    fill_in "Text", with: "Text for the Movie 1"

    click_button "Create Movie"

    expect(page).to have_content "Movie has been created."
  end  

  scenario "when providing invalid attributes" do
    click_button "Create Movie"

    expect(page).to have_content "Movie has not been created."
    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Text can't be blank"
  end
end
