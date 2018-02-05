class ItemController < ApplicationController

	get '/' do
		"this is the route in ItemController"
	end

	get '/add' do	
		@page = "Add Items"
		@action = "/items/add"
		@method = "POST"
		@placeholder = "Enter your item!"
		@value = ""
		@buttontext = "Add Item"
		erb :add_item
	end

	post '/add' do
		pp params
		
		@item = Item.new
		@item.title = params[:title]
		@item.user_id = 1
		@item.save

		@item.to_json
	end

end