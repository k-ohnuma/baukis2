class Staff::CustomersController < Staff::Base

  def index
    @customers = Customer.order(:family_name_kana, :given_name_kana).page(params[:page])
  end

  def show
    @customer = Customer.find_by(id: params[:id])
  end
end

