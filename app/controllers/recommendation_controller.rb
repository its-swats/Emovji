post '/recommendations' do 
	movie = Movie.find_or_create_by(title: params[:title].to_s)
	movie.recommendations.create(recommended: params[:type])
	p "sending message"
	send_twilio_message(params[:number], params[:title].to_s)
end
