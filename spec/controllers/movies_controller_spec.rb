require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  let(:user1) { FactoryGirl.create :user }
  let(:user2) { FactoryGirl.create :user }

  before do
    sign_in user1
  end

  it "handles a missing movie correctly" do
    get :show, id: "nothing"

    expect(response).to redirect_to(movies_path)

    message = "The movie you were looking for could not be found."
    expect(flash[:alert]).to eq message
  end

  it "handles permission errors by redirecting to a safe place" do
    allow(controller). to receive(:current_user)

    movie = FactoryGirl.create(:movie, user_id: user2.id)
    get :edit, id:movie

    expect(response).to redirect_to(root_path)
    message = "You are not allowed to do that."
    expect(flash[:alert]).to eq message
  end
end
