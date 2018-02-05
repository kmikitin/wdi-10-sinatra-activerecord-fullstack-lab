require 'sinatra/base'
require 'sinatra/activerecord'

# MODELS
require './models/ItemModel'
require './models/UserModel'

# CONTROLLERS
require './controllers/ApplicationController'
require './controllers/ItemController'
require './controllers/UserController'


# ROUTES
map('/') {
	run ApplicationController
}

map('/items') {
	run ItemController
}

map('/user') {
	run UserController
}