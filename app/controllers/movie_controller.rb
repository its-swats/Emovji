get '/movies' do

  keyword = movie_sorter(params)
  # p "*" * 20
  # p "ID: #{keyword}"
  # p "*" * 20
  auth_token = ENV['MOVIE_KEY']
  data = HTTParty.get("http://api.themoviedb.org/3/discover/movie?api_key=#{auth_token}&with_keywords=#{keyword[0]},#{keyword[1]}")
  data.to_json

end
