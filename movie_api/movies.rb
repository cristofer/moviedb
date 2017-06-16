require 'httparty'

token = "59742a86b9406b38503369b2c93a7642"
url = "http://localhost:3000/api/movies/17.json"

response = HTTParty.get(url,
    headers: {
      "Authorization" => "Token token=#{token}"
    }
  )

puts response.parsed_response
