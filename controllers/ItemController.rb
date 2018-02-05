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

		session[:message] = "You added item #{@item.title}."
		# @item.to_json

		redirect '/items'		
	end

	get '/edit/:id' do
		@item = Item.find params[:id]
		@page = "Edit Item #{@item.id}"
		erb :edit_item
	end

	patch '/:id' do
		@item = Item.find params[:id]
		@item.title = params[:title]
		@item.save

		session[:message] = "You updated item #{@item.title}."

		redirect '/items'
	end

	delete '/:id' do
		@item = Item.find params[:id]
		@item.delete

		session[:message] = "You deleted item #{@item.id}."

		redirect '/items'
	end

end