class Product < ApplicationRecord
	has_many :orders

	validates :name, presence: true
	validate :stock, :check_total_ordered

	def check_total_ordered
		if(total_ordered > stock)
			Rails.logger.error("ERROR: total_ordered greater than stock, TRACE: #{self.class.name}#check_total_ordered")
			errors.add(:base, "Total de pedidos maior que o estoque")
		end
	end

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
