class ItemController < ApplicationController
	# this is a filter
	before do 
		if !session[:logged_in]
			session[:message] = "You must be logged in to do anything, bro"
			redirect '/user/login'
		end
	end

	# this is the route for all the ajax calls
	get '/ajax' do
		erb :item_index_ajax
	end

	# this is the index route
	get '/' do
		# @items = Item.all
		@user = User.find session[:user_id]
		@items = @user.items.order(:id) #make the list sttay in the same order
		# @items.to_json
		erb :item_index
	end

	# this is the json index route
	get '/j' do
		@user = User.find session[:user_id]
		@items = @user.items.order(:id)
		# @items.to_json

		# building our API response
		# instead of just sending back random json
		resp = {
			status: {
				all_good: true,
				number_of_results: @items.length
			},
			items: @items
		}
		resp.to_json

	end


	# this is the create route (add new)
	get '/add' do	
		@page = "Add Items"
		@action = "/items/add"
		@method = "POST"
		@placeholder = "Enter your item!"
		@value = ""
		@buttontext = "Add Item"
		erb :add_item
	end

	# this is the post route for the create
	post '/add' do
		pp params
		
		@item = Item.new
		@item.title = params[:title]
		@item.user_id = session[:user_id]
		@item.save

		session[:message] = "You added item #{@item.title}."
		# @item.to_json

		redirect '/items'		
	end

	# the is the create route for the json/ajax call
	post '/j' do
		@item = Item.new
		@item.title = params[:title]
		@item.user_id = session[:user_id]
		@item.save

		resp = {
			status: {
				all_good: true,
			},
			item: @item
		}

		resp.to_json
	end


	# this is the edit route
	get '/edit/:id' do
		@item = Item.find params[:id]
		@page = "Edit Item #{@item.id}"
		erb :edit_item
	end

	# this is the update route
	patch '/:id' do
		@item = Item.find params[:id]
		@item.title = params[:title]
		@item.save

		session[:message] = "You updated item #{@item.title}."

		redirect '/items'
	end

	# this is the delete route
	delete '/:id' do
		@item = Item.find params[:id]
		@item.delete

		session[:message] = "You deleted item #{@item.id}."

		redirect '/items'
	end

end