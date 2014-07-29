require 'sinatra'
require 'postmark'

class SiteClimate < Sinatra::Base
	enable :sessions
	
	get '/' do
		@notice = session[:notice]
		erb :index
	end
	
	get '/terms' do
		File.read(File.join('terms.html'))
	end
	
	get '/terms.html' do
		File.read(File.join('terms.html'))
	end
	
	get '/privacy' do
		File.read(File.join('privacy.html'))
	end
	
	get '/privacy.html' do
		File.read(File.join('privacy.html'))
	end
	
	post '/sendemail' do
		your_api_key = ENV['POSTMARK_API_KEY']
		client = Postmark::ApiClient.new(your_api_key)
		email = params['email']
	  	client.deliver(from: 'system@siteclimate.com',
	  	            to: 'siteclimate@gmail.com',
	  	            subject: "[new beta email] #{email}",
	  	            text_body: "Awesome! #{email} is interested in the app! Go you!")
	  	notice = 'Thank you for submitting your email. We will contact you when we are ready for your help.'
	  	session[:notice] = notice
	  	redirect "/", 302
	end
end	
