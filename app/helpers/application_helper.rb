module ApplicationHelper
  
  def full_name(customer)
    customer.last_name + customer.first_name
  end

	def kana_full_name(customer)
		customer.last_name_kana + customer.first_name_kana
	end
	
  def current_customer?(customer)
        customer == current_customer
  end
  
  def full_address(order)
    '〒' + order.postal_code + ' ' + order.address
  end
end
