require 'httparty'

###
# API V2
#

token = "59742a86b9406b38503369b2c93a7642"

###listing a specific movie
url = "http://localhost:3000/api/v2/movies/27"

###listing all the movies
#url = "http://localhost:3000/api/v2/movies/"

###Listing the movie(s)
response = HTTParty.get(url,
    headers: {
      "Authorization" => "Token token=#{token}"
    }
  )

# Create a movie (method: POST)
# params = { title: "Movie 1", text: "Text 1" }

###
# Update a movie (method: PATCH)
# params = { movie: ID, params: { title: "Movie 1", text: "Text 1" } }

###
# Delete a movie (method: DELETE)
# params = { movie: ID }


puts response.parsed_response
