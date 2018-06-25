class Ficha < ApplicationRecord
	belongs_to :client
	has_many :orders

	validates :client, uniqueness: true

	# Virtual fields for rails admin
	def city
		self.client.city
	end

	def orders_price
		self.orders.eager_load(:product).pluck(:product_count,:price).sum {|c, p| (c * p).to_f}
	end

	RailsAdmin.config do |config|
	  config.model 'Ficha' do
	    list do
	    	field :id
	      field :client, :belongs_to_association do
	      	label 'nome do cliente'
	      end
	      field :city do
	      	label 'cidade'
  	      filterable true
  	      searchable do
  	      	[{clients: :city}]
  	      end
	      end
	      field :orders, :has_many_association do
	      	label 'produtos pedidos'
	      	def pretty_value
	      		products = value.map { |v| "<a target='blank' href ='/order/#{v.id}'>#{v.product.name} (#{v.product_count})</a>" }.join("<br>").html_safe
	      	end
	      end
	      field :orders_price do
	      	label 'valor total dos pedidos'
	      end
	      field :return_date do label 'data de retorno' end
	      field :print do
	      	def pretty_value
	      		ficha = bindings[:object]
	      		client = ficha.client
	      		orders = ficha.orders.map { |o| "#{o.product.name} (#{o.product_count})" }.join(";")
	      		link = "
	      		<div id='printform#{ficha.id}')>

	      		</div>
	      		<script>
	      			var f = document.createElement('form');
							f.setAttribute('method','post');
							f.setAttribute('action','#{bindings[:view].main_app.reports_path}');
							f.target='_blank';

							var client_name = document.createElement('input');
							client_name.setAttribute('type','hidden');
							client_name.setAttribute('name','client_name');
							client_name.setAttribute('value','#{client.name}');

							var client_rg = document.createElement('input');
							client_rg.setAttribute('type','hidden');
							client_rg.setAttribute('name','client_rg');
							client_rg.setAttribute('value','#{client.rg}');

							var client_cpf = document.createElement('input');
							client_cpf.setAttribute('type','hidden');
							client_cpf.setAttribute('name','client_cpf');
							client_cpf.setAttribute('value','#{client.cpf}');

							var client_phone = document.createElement('input');
							client_phone.setAttribute('type','hidden');
							client_phone.setAttribute('name','client_phone');
							client_phone.setAttribute('value','#{client.phone}');

							var client_address = document.createElement('input');
							client_address.setAttribute('type','hidden');
							client_address.setAttribute('name','client_address');
							client_address.setAttribute('value','#{client.address}');

							var client_neighborhood = document.createElement('input');
							client_neighborhood.setAttribute('type','hidden');
							client_neighborhood.setAttribute('name','client_neighborhood');
							client_neighborhood.setAttribute('value','#{client.neighborhood}');

							var client_city = document.createElement('input');
							client_city.setAttribute('type','hidden');
							client_city.setAttribute('name','client_city');
							client_city.setAttribute('value','#{client.city}');

							var orders = document.createElement('input');
							orders.setAttribute('type','hidden');
							orders.setAttribute('name','orders');
							orders.setAttribute('value','#{orders}');

							var s = document.createElement('input');
							s.setAttribute('type','submit');
							s.setAttribute('value','Imprimir');

							// TODO: Append many elements at once
							f.appendChild(client_name);
							f.appendChild(client_rg);
							f.appendChild(client_cpf);
							f.appendChild(client_phone);
							f.appendChild(client_address);
							f.appendChild(client_neighborhood);
							f.appendChild(client_city);
							f.appendChild(orders);
							f.appendChild(s);

							document.getElementById('printform#{ficha.id}').appendChild(f);
	      		</script>
	      		"
	      		link.html_safe
	      	end
	      end
	    end

	    show do
	    	field :id
	      field :client, :belongs_to_association do
	      	label 'nome do cliente'
	      end
	      field :endereco do
			    formatted_value{ bindings[:object].client.address }
			  end
			  field :phone do
			    formatted_value{ bindings[:object].client.phone }
			  end
	      field :return_date do label 'data de retorno' end
	      field :orders, :has_many_association do
	      	label 'produtos pedidos'
	      	def pretty_value
	      		products = value.map { |v| "<a target='blank' href ='/order/#{v.id}'>#{v.product.name} (#{v.product_count})</a>" }.join("<br>").html_safe
	      	end
	      end
	      field :created_at
	      field :updated_at
	    end


	    # Custom Edit
    	# edit do
	    #   field :return_date do
	    #   	partial 'teste'
	    #   end
	    # end
	  end
	end
end
