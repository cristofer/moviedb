require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  it "handles a missing movie correctly" do
    get :show, id: "nothing"

    expect(response).to redirect_to(movies_path)

    message = "The movie you were looking for could not be found."
    expect(flash[:alert]).to eq message
  end
end
