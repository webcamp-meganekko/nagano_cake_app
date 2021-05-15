module ApplicationHelper
  
  def full_name(customer)
    customer.first_name + customer.last_name
  end

	def kana_full_name(customer)
		customer.first_name_kana + customer.last_name_kana
	end
	
  def current_customer?(customer)
        customer == current_customer
  end
	
end
