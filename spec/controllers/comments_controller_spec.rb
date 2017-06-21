require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:movie) { FactoryGirl.create(:movie) }

  before do
    sign_in user
  end

  context "with valid attribute" do
    it "can create a post" do
      post :create, { comment: {text: "Comment"}, movie_id: movie.id, :format => 'js' }

      movie.reload
      expect(movie.comments.count).to eq(1)
    end
  end

  context "with invalid attribute" do
    it "can create a post" do
      post :create, { comment: {text: ""}, movie_id: movie.id }

      movie.reload
      expect(movie.comments.count).to eq(0)
    end
  end
end
