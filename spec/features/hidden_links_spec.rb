require 'rails_helper'

RSpec.feature "Users can only see the appropiate links" do
  let(:user1) { FactoryGirl.create(:user) } 
  let(:user2) { FactoryGirl.create(:user) } 
  let!(:movie1) { FactoryGirl.create(:movie, user: user1) } 

  context "anonymous users" do
    scenario "cannot see the New Movie link" do
      visit "/"
      expect(page).not_to have_link "New Movie"
    end
  end

  context "regular users" do
    scenario "owners can see 'Delete Movie'" do
      login_as(user1)
      visit "/"
      expect(page).to have_link "Delete Movie"

      visit movie_path(movie1)
      expect(page).to have_link "Delete Movie"
    end

    scenario "owners can see 'Edit Movie'" do
      login_as(user1)
      visit "/"
      expect(page).to have_link "Edit Movie"

      visit movie_path(movie1)
      expect(page).to have_link "Edit Movie"
    end

    scenario "non-ownsers cannot see 'Delete Movie'" do
      login_as(user2)
      visit "/"
      expect(page).not_to have_link "Delete Movie"

      visit movie_path(movie1)
      expect(page).not_to have_link "Delete Movie"
    end

    scenario "non-ownsers cannot see 'Edit Movie'" do
      login_as(user2)
      visit "/"
      expect(page).not_to have_link "Edit Movie"

      visit movie_path(movie1)
      expect(page).not_to have_link "Edit Movie"
    end
  end
end
