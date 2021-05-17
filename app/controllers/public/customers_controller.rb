class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!, except: [:quit]

  def show
    @customer = current_customer
  end


  def edit
    @customer = current_customer
  end

  def update
    customer = current_customer
    if customer.update(customer_params)
       flash[:success] = "登録情報を変更しました"
       redirect_to customer_show_path
    else
       render 'edit'
    end
  end

  def quit_confirm
  end

  def quit
    current_customer.update(is_valid: false)
    sign_out(current_customer)
  end

  private
  
    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :email, :postal_code, :address, :tell)
    end

end

