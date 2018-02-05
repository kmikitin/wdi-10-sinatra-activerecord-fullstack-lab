class ItemController < ApplicationController

	get '/' do
		@items = Item.all
		# @items.to_json
		erb :item_index
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

		# @item.to_json

		redirect '/items'		
	end

	delete '/:id' do
		@item = Item.find params[:id]
		@item.delete
		redirect '/items'
	end

end