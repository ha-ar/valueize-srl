class CashMangmentsController < ApplicationController
	before_action :authenticate_user!, only: [:create]
	before_action :get_company
	before_action :set_cash_managment, only: [:show, :destroy]

  def index
  	@cash_managments = @company.cash_managments
  	json_response(@cash_managments, 'Company all cash managments')
  end

  def show
  	json_response(@cash_managment, "cash managment detail")
  end

  def create
  	@cash_managment = @company.cash_managments.new(cash_managment_params)
  	if @cash_managment.save
  		json_response(@cash_managment, "cash managment created")
	  else
	  	json_error_response(@cash_managment.errors, '', :unprocessable_entity)
  	end
  end

  def destroy
  	@cash_managment.destroy
  end

  private

  def get_company
  	@company = Company.find(params[:company_id])
  end

  def cash_managment_params
  	params.require(:cash_managment).permit(:initial_cash, :cash_in, :revenues, :equity, :convertibe_note, :bank_debt, :cashin_others, :cash_out, :cogs, :employees, :services, :operation_expenses, :investments, :cashout_others, :end_cash_balance)
  end

  def set_cash_managment
  	@cash_managment = CashManagment.find(params[:id])
  end
end
