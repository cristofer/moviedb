require 'rails_helper'

RSpec.describe MoviesController, type: :controller do

  it "handles a missing movie correctly" do
    get :show, id: "nothing"

    expect(response).to redirect_to(movies_path)

    message = "The movie you were looking for could not be found."
    expect(flash[:alert]).to eq message
  end

  it "handles permission errors by redirecting to a safe place" do
    user = FactoryGirl.create(:user)
    sign_in user

    allow(controller).to receive(:current_user)

    movie = FactoryGirl.create(:movie)
    get :edit, id: movie

    expect(response).to redirect_to(root_path)
    message = "You aren't allowed to do that."
    expect(flash[:alert]).to eq message
  end

end
