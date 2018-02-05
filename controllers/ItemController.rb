class ItemController < ApplicationController

	get '/' do
		"this is the route in ItemController"
	end

	get '/add' do	
		erb :add_item
		@page = "Add Item"
		@action = "/items/add"
		@method = "POST"
		@placeholder = "Enter your item!"
		@value=""
		@buttontext = "Add Item"
	end
end