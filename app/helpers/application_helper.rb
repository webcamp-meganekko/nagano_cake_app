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
  
  def full_address_for(address)
    "〒" + address.postal_code + "  " + address.street_address + "  " + address.receve_name 
  end
  
#合計金額の計算
  def sum(carts)
    sum = 0
    carts.each{|cart| sum += (cart.product.price * 1.08).floor * cart.quantity }
    return sum
  end
    
end
