class ReportController < ApplicationController
	skip_before_action :verify_authenticity_token

	def show
		binding.pry
	end
end