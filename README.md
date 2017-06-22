# About MovieDB

MovieDB is just a small IMDd, I will be improving it just for fun.

## Features

* Movie: Title, Text, Ratings, Category, Comments
* Movie has all REST actions
* C(R)UD of own movies only for logged-in users
* Rating (5 star system) of movies only for logged-in users
* Create Comments for movies only for logged-in users
* Home page = listing of all movies including full text search and facets of categories and ratings:
 * Example for categories:
   * Action (5)
   * Drama (2)
   * ...
 * Example for ratings:
   * 5 Stars (4)
   * 4 Stars (9)
   * ...
 * Clicking on a facet filters the movie list accordingly without a page reload
 * In the movie list the logged users are able to rate the movie without a page reload
 * Next to it should be the buttons for C(R)UD actions if it's the user's movie
 * Pagination for more than 10 items

## API (v1)

There is a very simple API that display an specific Movie, and also allows to create a movie.

The API Key is nex to the "Signed in" text when you are logged in.

You can update the values into movie_api/movies.rb  in order to make a simple request

## API (v2 with Sinatra)

A new version for the API, this time using Sinatra inside the Rails app.

Check the values in the file: movie_api/movies-v2.rb

## Somes Gems I have used in this project

 * Testing with RSpec and Capybara (including JS)
 * For testing security and good practices:
   * [Rubycritic](https://github.com/whitesmith/rubycritic)
   * [Rubocop](https://github.com/bbatsov/rubocop)
   * [Brakeman](http://brakemanscanner.org)
 * Ajax pagination: [Kaminari](https://github.com/kaminari/kaminari)
 * Notifications: [Gritter](https://github.com/RobinBrouwer/gritter)
 * API V2: [Sinatra](http://www.sinatrarb.com)
 * Uplading images: [Carrierwave] (https://github.com/carrierwaveuploader/carrierwave)
 * Charts for ratings: [Chartkick](http://chartkick.com)
