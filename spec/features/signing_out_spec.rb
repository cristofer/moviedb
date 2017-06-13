require 'rails_helper'

RSpec.feature "Signed-in users can sign out" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:movie) { FactoryGirl.create(:movie, user: user, title: "Movie 1") }

  before do
    login_as(user)
  end

  scenario do
    visit "/"
    click_link "Sign out"
    expect(page).to have_content "Movie 1"
  end
end
