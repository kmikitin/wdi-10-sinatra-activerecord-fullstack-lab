class ApplicationController < Sinatra::Base

	require 'bundler'
	Bundler.require()

	get '/' do
		"hey cool the server runs"
	end

end