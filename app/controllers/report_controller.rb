class ReportController < ApplicationController
	skip_before_action :verify_authenticity_token

	def show
		if(params[:multiprint])
			@client_names = JSON.parse(params["client_names"])
			@client_rgs = JSON.parse(params["client_rgs"])
			@client_cpfs = JSON.parse(params["client_cpfs"])
			@client_phones = JSON.parse(params["client_phones"])
			@client_addresses = JSON.parse(params["client_addresses"])
			@client_neighborhoods = JSON.parse(params["client_neighborhoods"])
			@client_cities = JSON.parse(params["client_cities"])
			@orders = JSON.parse(params["orders"])
		else
			@client_names = { "0" => params["client_names"] }
			@client_rgs = { "0" => params["client_rgs"] }
			@client_cpfs = { "0" => params["client_cpfs"] }
			@client_phones = { "0" => params["client_phones"] }
			@client_addresses = { "0" => params["client_addresses"] }
			@client_neighborhoods = { "0" => params["client_neighborhoods"] }
			@client_cities = { "0" => params["client_cities"] }
			@orders = { "0" => params["orders"] }
		end
	end
end