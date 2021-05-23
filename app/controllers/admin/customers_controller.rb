class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_customer, only: [:show, :edit, :update]
  
  def index
    @customers = Customer.page(params[:page]).per(10)
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @customer.update(customer_params)
      flash[:notice] = "会員情報を変更しました。"
      redirect_to admin_customers_path
    else
      render 'edit'
    end
  end
  
  private
  def customer_params
     params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana,
                                      :email, :is_valid, :postal_code, :address, :tell)
  end
  
  def set_customer
    @customer = Customer.find(params[:id])
  end
end
