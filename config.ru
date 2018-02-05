require 'sinatra/base'
require 'sinatra/activerecord'

# MODELS
require './models/ItemModel'

# CONTROLLERS
require './controllers/ApplicationController'
require './controllers/ItemController'


# ROUTES
map('/') {
	run ApplicationController
}

map('/items') {
	run ItemController
}