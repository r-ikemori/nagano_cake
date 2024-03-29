class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!, except: [:top, :about]
  def index
    @address = Address.new
    @customer = current_customer
    @addresses = @customer.addresses
  end
  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @address.save!
    redirect_to addresses_path
  end
  def destroy
    @address = Address.find(address_params)
    @address.destroy
    redirect_to addresses_path
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
   address =Address.find(params[:id])
   address.update(address_params)
   redirect_to addresses_path
  end

   private

  def address_params
    params.require(:address).permit(:postal_code, :name, :address)
  end
end
