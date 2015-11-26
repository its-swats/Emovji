
get '/movies' do
  p params
  auth_token = ENV['MOVIE_KEY']
  data = HTTParty.get("http://api.themoviedb.org/3/discover/movie?api_key=#{auth_token}") # =>
  data.to_json

end
