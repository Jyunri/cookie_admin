class ReportController < ApplicationController
	skip_before_action :verify_authenticity_token

	def show
		if(params[:multiprint])
			@client_name = JSON.parse(params["client_names"])
			@client_rg = JSON.parse(params["client_rgs"])
			@client_cpf = JSON.parse(params["client_cpfs"])
			@client_phone = JSON.parse(params["client_phones"])
			@client_address = JSON.parse(params["client_addresses"])
			@client_neighborhood = JSON.parse(params["client_neighborhoods"])
			@client_city = JSON.parse(params["client_cities"])
			@orders = JSON.parse(params["orders"])
		else
			@client_name = params["client_names"]
			@client_rg = params["client_rgs"]
			@client_cpf = params["client_cpfs"]
			@client_phone = params["client_phones"]
			@client_address = params["client_addresses"]
			@client_neighborhood = params["client_neighborhoods"]
			@client_city = params["client_cities"]
			@orders = params["orders"]
		end
	end
end