require "rails_helper"

describe API::V2::Movies do
  let!(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let!(:movie) { FactoryGirl.create(:movie, user: user) }
  let(:url) { "/api/v2/movies/#{movie.id}" }
  let(:url_root) { "/api/v2/movies/" }
  let(:headers) do
    { "HTTP_AUTHORIZATION" => "Token token=#{user.api_key}" }
  end
  let(:headers_different_user) do
    { "HTTP_AUTHORIZATION" => "Token token=#{user2.api_key}" }
  end

  context "successful request" do
    it "can view a movie' details" do
      get url, {}, headers

      expect(response.status).to eq 200
      json = MovieSerializer.new(movie).to_json
      expect(response.body).to eq json
    end

    it "can list all the movies" do
      get url_root, {}, headers

      expect(response.status).to eq 200
      json = "[" + MovieSerializer.new(movie).to_json + "]"
      expect(response.body).to eq json
    end

    it "can create a movie" do
      params = {
        title: "Movie - API2",
        text: "Description - API2"
      }

      post url_root, params, headers

      expect(response.status).to eq 200
      json = {"result" => "The movie was created"}.to_json
      expect(response.body).to eq json
    end

    it "can update a movie" do
      params = {
        movie: movie.id,
        params: {
          title: "Movie - API2 - Updated",
          text: "Description - API2 - Updated",
        }
      }

      patch url_root, params, headers

      expect(response.status).to eq 200
      json = {"result" => "The movie was updated"}.to_json
      expect(response.body).to eq json
    end

    it "can delete a movie" do
      params = {
        movie: movie.id,
      }

      delete url_root, params, headers

      expect(response.status).to eq 200
      json = {"result" => "The movie was deleted"}.to_json
      expect(response.body).to eq json
    end
  end

  context "unsuccessful requests" do
    it "doesn't allow requests that don't pass through an API key" do
      get url
      expect(response.status).to eq 401
      expect(response.body).to include "Unauthenticated"
    end

    it "doesn't allow requests that pass an invalid API key" do
      get url, {}, { "HTTP_AUTHORIZATION" => "Token token=novalid" }
      expect(response.status).to eq 401
      expect(response.body).to include "Unauthenticated"
    end

    it "cannot create a movie with invalid values" do
      params = {
        title: "",
        text: ""
      }

      post url_root, params, headers

      expect(response.status).to eq 500
      json = {"error" => "The movie was not created"}.to_json
      expect(response.body).to eq json
    end

    it "cannot delete a movie if is not the owner" do
      params = {
        movie: movie.id,
      }

      delete url_root, params, headers_different_user

      expect(response.status).to eq 500
      json = {"error" => "You are not authorized to delete the movie"}.to_json
      expect(response.body).to eq json
    end

    it "cannot update a movie if is not the owner" do
      params = {
        movie: movie.id,
        params: {
          title: "Movie - API2 - Updated",
          text: "Description - API2 - Updated",
        }
      }

      patch url_root, params, headers_different_user

      expect(response.status).to eq 500
      json = {"error" => "You are not authorized to update the movie"}.to_json
      expect(response.body).to eq json
    end
  end
end
