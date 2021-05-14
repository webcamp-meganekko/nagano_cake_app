class Admin::CustomersController < ApplicationController
  
  def index
    @customers = Customer.all
  end
  
  def show
    @customer = Customer.find(params[:id])
  end
  
  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    @customer = Customer.update(customer_params)
    redirect_to admin_customers_path
  end
  
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    redirect_to admin_customers_path
  end
  
  private
  def customer_params
     params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana,
                                      :email, :is_valid, :postal_code, :address, :tell)
  end
end
