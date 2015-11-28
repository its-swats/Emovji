post '/recommendations' do 
	movie = Movie.find_or_create_by(title: params[:title])
	movie.recommendations.create(recommended: params[:type])
end
