require 'httparty'

token = "59742a86b9406b38503369b2c93a7642"

###listing a specific movie
url = "http://localhost:3000/api/movies/27.json"

###listing all the movies
#url = "http://localhost:3000/api/movies/"

###Listing the movie(s)
#response = HTTParty.get(url,
#    headers: {
#      "Authorization" => "Token token=#{token}"
#    }
#  )

###Deleting a movie
#response = HTTParty.delete(url,
#    headers: {
#      "Authorization" => "Token token=#{token}"
#    }
#  )

#url = "http://localhost:3000/api/movies/27.json"
params = { movie: {title: "Title edited", text: "Text edited"} }
#params = { movie: {title: "Title edited without text"} }
#params = { movie: {title: ""} }

response = HTTParty.patch(url,
    headers: {
      "Authorization" => "Token token=#{token}"
    },
    query: params
  )


puts response.parsed_response
