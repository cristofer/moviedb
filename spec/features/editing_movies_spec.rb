require 'rails_helper'

RSpec.feature "Users can edit existing movies" do
  before do
    FactoryGirl.create(:movie)

    visit "/"
    click_link "Movie 1"
    click_link "Edit Movie"
  end

  scenario "with valid attributes" do
    fill_in "Title", with: "Movie 1 Edited"
    fill_in "Text", with: "Text 1 Edited"
    click_button "Update Movie"

    expect(page).to have_content "Movie has been updated."
    expect(page).to have_content "Movie 1 Edited"
    expect(page).to have_content "Text 1 Edited"
  end

  scenario "when providing invalid arttributes" do
    fill_in "Title", with: ""
    fill_in "Text", with: ""
    click_button "Update Movie"

    expect(page).to have_content "Movie has not been updated."
  end
end
