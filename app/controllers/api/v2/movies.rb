require 'sinatra'

module API
  module V2
    class Movies < Sinatra::Base
      register Sinatra::StrongParams

      before do
        headers 'Content-Type' => 'text/json'
        set_user
      end

      get '/:id' do
        movie = Movie.find(params[:id])
        MovieSerializer.new(movie).to_json
      end

      get '/' do
        movies = Movie.list_all
        ActiveModelSerializers::SerializableResource.new(movies).to_json
      end

      post '/', allows: %i[title text] do
        movie = Movie.new(params)

        if movie.save
          { result: 'The movie was created' }.to_json
        else
          halt 500, { error: 'The movie was not created' }.to_json
        end
      end

      patch '/', allows: %i[movie params] do
        movie = Movie.find(params[:movie])

        unless movie.user == @user
          err = 'You are not authorized to update the movie'
          halt 500, { error: err }.to_json
        end

        if movie.update(params[:params].slice(:title, :text))
          { result: 'The movie was updated' }.to_json
        else
          halt 500, { error: 'The movie was not updated' }.to_json
        end
      end

      delete '/', allows: %i[movie] do
        movie = Movie.find(params[:movie])

        unless movie.user == @user
          err = 'You are not authorized to delete the movie'
          halt 500, { error: err }.to_json
        end

        movie.destroy

        { result: 'The movie was deleted' }.to_json
      end

      private

      def params
        hash = env['action_dispatch.request.path_parameters'].merge!(super)
        HashWithIndifferentAccess.new(hash)
      end

      def set_user
        if env['HTTP_AUTHORIZATION'].present?
          if (auth_token = /Token token=(.*)/.match(env['HTTP_AUTHORIZATION']))
            @user = User.find_by(api_key: auth_token[1])
            return @user if @user.present?
          end
        end

        unauthenticated!
      end

      def unauthenticated!
        halt 401, { error: 'Unauthenticated' }.to_json
      end
    end
  end
end
