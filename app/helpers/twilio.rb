helpers do 

	def send_twilio_message(number, movie)
		account_sid = ENV['TWILIO_SID']
		auth_token = ENV['TWILIO_SECRET']
		p account_sid
		client = Twilio::REST::Client.new account_sid, auth_token

		from = "+18059198596"

		client.account.messages.create(
		:from => from,
		:to => "+#{number}",
		:body => "A friend of yours has recommended that you watch #{movie} via Emovji!"
		)

	end

end