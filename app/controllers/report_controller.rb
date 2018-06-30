class ReportController < ApplicationController
	skip_before_action :verify_authenticity_token

	def show
		binding.pry
		@fichas = params["batchData"].split(/(?=client_name)/)
		@client_name = params["client_name"]
		@client_rg = params["client_rg"]
		@client_cpf = params["client_cpf"]
		@client_phone = params["client_phone"]
		@client_address = params["client_address"]
		@client_neighborhood = params["client_neighborhood"]
		@client_city = params["client_city"]
		@orders = params["orders"]
	end
end