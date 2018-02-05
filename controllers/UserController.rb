class UserController < ApplicationController

	# the index route
	get '/' do
		redirect '/user/login'
	end

	# the login get route
	get '/login' do
		erb :login
	end

	# the register get route
	get '/register' do
		erb :register
	end

	# the login post route
	post '/login' do
		@pw = params[:password]
		@user = User.find_by(username: params[:username])

		if @user && @user.authenticate(@pw)
			session[:username] = @user.username
			session[:user_id] = @user.id
			session[:logged_in] = true
			session[:message] = "Logged in as #{@user.username}"
			redirect '/items/ajax'
		else
			session[:message] = "Invalid username or password, please try again"
			redirect '/user/login'
		end

	end

	# the register post route
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

	# the get route to logout
	get '/logout' do
		session[:username] = nil
		session[:user_id] = nil
		session[:logged_in] = false
		session[:message] = "You have logged out. Bye."
		redirect '/user/login'
	end

end