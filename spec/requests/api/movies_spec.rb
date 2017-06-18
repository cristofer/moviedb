require 'rails_helper'

RSpec.describe "Movies API" do
  let(:user) { FactoryGirl.create(:user) }
  let!(:movie) { FactoryGirl.create(:movie, user: user) }

  before do
    user.generate_api_key
  end

  context "as an authenticated user" do
    let(:headers) do
      { "HTTP_AUTHORIZATION" => "Token token=#{user.api_key}" }
    end

    it "retrieves a movie's information" do
      get api_movie_path(movie, format: :json),
        {}, headers

      expect(response.status).to eq 200

      json = MovieSerializer.new(movie).to_json
      expect(response.body).to eq json
    end

    it "retrieves all the movies" do
      get api_movies_path(format: :json),
        {}, headers

      expect(response.status).to eq 200

      json = "[" + MovieSerializer.new(movie).to_json + "]"
      expect(response.body).to eq json
    end

    it "can create a movie" do
      params = {
        format: "json",
        movie: {
          title: "Movie - API",
          text: "Description - API"
        }
      }

      post api_movies_path(params), {}, headers

      expect(response.status).to eq 201
      json = MovieSerializer.new(Movie.last).to_json
      expect(response.body).to eq json
    end

    it "cannot create a movie with invalid data" do
      params = {
        format: "json",
        movie: {
          title: "",
          text: ""
        }
      }

      post api_movies_path(params), {}, headers

      expect(response.status).to eq 422
      json = {
        "errors" => [
          "Title can't be blank",
          "Text can't be blank"
        ]
      }
      expect(JSON.parse(response.body)).to eq json
    end

    it "can update a movie" do
      params = {
        format: "json",
        movie: {
          title: "Movie - API - Updated",
          text: "Description - API - Updated"
        }
      }

      patch api_movie_path(movie, params), {}, headers

      expect(response.status).to eq 200
      json = {message: "The movie was updated"}.to_json
      expect(response.body).to eq json
    end

    it "cannot update a movie with invalid parameters" do
      params = {
        format: "json",
        movie: {
          title: "",
          text: ""
        }
      }

      patch api_movie_path(movie, params), {}, headers

      expect(response.status).to eq 400
      json = {error: "The movie was not updated"}.to_json
      expect(response.body).to eq json
    end
  end

  context "as an unauthenticated user" do

    it "responds with a 401" do
      get api_movie_path(movie, format: :json)

      expect(response.status).to eq 401
      error = { "error" => "Unauthorized" }
      expect(JSON.parse(response.body)).to eq error
    end
  end
end
