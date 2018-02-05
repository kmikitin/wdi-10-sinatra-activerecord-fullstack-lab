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

		if @user && @user.password == params[:password]
			session[:username] = @user.username
			session[:user_id] = @user.id
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
		session[:user_id] = @user.id
		session[:message] = "Thank you for signing up!"
		redirect '/items'
	end

	get '/logout' do
		session[:username] = nil
		session[:user_id] = nil
		session[:logged_in] = false
		session[:message] = "You have logged out. Bye."
		redirect '/user/login'
	end

end