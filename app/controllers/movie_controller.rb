get '/movies' do

  keyword = movie_sorter(params)
  p keyword
  auth_token = ENV['MOVIE_KEY']
  data = HTTParty.get("http://api.themoviedb.org/3/discover/movie?api_key=#{auth_token}")
  p keyword
  data.to_json

end
