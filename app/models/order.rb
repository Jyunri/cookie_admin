class Order < ApplicationRecord
	belongs_to :product
	belongs_to :ficha

	validate :product_count, :check_total_ordered

	private
		def check_total_ordered
			old_product_count = product_count_was
	  	new_product_count = product_count

	  	product = Product.find_by(id: product_id)

	  	if(old_product_count)
		  	product_count_delta = new_product_count - old_product_count

		    product.total_ordered += product_count_delta

		    unless product.save
		    	Rails.logger.error("ERROR: total_ordered greater than stock, TRACE: #{self.class.name}#check_total_ordered")
					errors.add(:base, "Total de pedidos maior que o estoque")
		    end
		   else
		   	product.total_ordered = new_product_count
		   end
		end
end
