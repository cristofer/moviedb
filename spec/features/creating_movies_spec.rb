require "rails_helper"

RSpec.feature "Users can create new movies" do

  let(:user) { FactoryGirl.create(:user) }
  let!(:category1) { FactoryGirl.create(:category, name: "First One") }
  let!(:category2) { FactoryGirl.create(:category, name: "Second One") }

  before do
    login_as(user)
    visit "/"
    click_link "New Movie"
  end

  scenario "with valid attributes" do
    fill_in "Title", with: "Movie 1"
    fill_in "Text", with: "Text for the Movie 1"
    check "First One"

    click_button "Create Movie"

    expect(page).to have_content "Movie has been created."
    expect(page).to have_content "First One"
    expect(page).not_to have_content "Second One"
  end  

  scenario "when providing invalid attributes" do
    click_button "Create Movie"

    expect(page).to have_content "Movie has not been created."
    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Text can't be blank"
  end
end
