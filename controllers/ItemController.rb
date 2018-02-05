class ItemController < ApplicationController

	get '/' do
		"this is the route in ItemController"
	end

	get '/add' do	
		erb :add_item
	end
end