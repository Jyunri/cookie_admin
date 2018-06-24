class Product < ApplicationRecord
	has_many :orders

	validates :name, presence: true

	RailsAdmin.config do |config|
	  config.model 'Product' do
			configure :orders do
		    hide
		    # for list view
		    filterable false
		    searchable false
			end
		end
	end

end
