get '/movies' do
# p params
  search_string = movie_sorter(params)
  # p "*" * 20
  # p "ID: #{keyword}"
  # p "*" * 20
  auth_token = ENV['MOVIE_KEY']
  data = HTTParty.get("http://api.themoviedb.org/3/discover/movie?api_key=#{auth_token}#{search_string}")
  data.to_json
end
