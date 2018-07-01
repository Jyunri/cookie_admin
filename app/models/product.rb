class Product < ApplicationRecord
	has_many :orders

	validates :name, presence: true
	validates :stock, :numericality => { :greater_than_or_equal_to => 0 }

	RailsAdmin.config do |config|
	  config.model 'Product' do
			configure :orders do
		    hide
		    # for list view
		    filterable false
		    searchable false
			end
			list do
				field :id
				field :name do
					label 'nome'
				end
				field :price do
					label 'preço'
				end
				field :stock do
					label 'estoque'
				end
				field :total_ordered do
					label 'total encomendado'
				end
			end

			edit do
				field :id
				field :name do
					label 'nome'
				end
				field :price do
					label 'preço'
				end
				field :stock do
					label 'estoque'
				end
			end
		end
	end

end
