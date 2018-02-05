class UserController < ApplicationController

	get '/' do
		redirect '/user/login'
	end

	get '/login' do
		erb :login
	end

	get '/register' do
		erb :register
	end

	post '/login' do
		@user = User.find_by(username: params[:username])

		if @user && user.password == params[:password]
			session[:username] = @user.username
			session[:logged_in] = true
			session[:message] = "Logged in as #{@user.username}"
			redirect '/items'
		else
			session[:message] = "Invalid username or password, please try again"
			redirect '/user/login'
		end

	end

	post '/register' do
		@user = User.new
		@user.username = params[:username]
		@user.password = params[:password]
		@user.save

		session[:logged_in] = true
		session[:username] = @user.username
		session[:message] = "Thank you for signing up!"
		redirect '/items'
	end

end