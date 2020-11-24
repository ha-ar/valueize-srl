class CompaniesController < ApplicationController
	respond_to :json
	before_action :authenticate_user!, only: [:create]
	before_action :set_company, only: [:show, :update, :destroy]
  
  def index
  	@companies = Company.all
  	json_response(@companies, 'All Companies')
  end

  def show
  	json_response(@company, 'Single Company')
  end

  def create
  	if current_user.student?
	  	@company = current_user.companies.new(company_params)
	  	if @company.save
	  		json_response(@company, "company created")
	  	else
	  		json_error_response(@company.errors, '', :unprocessable_entity)
	  	end
	  else
	  	json_error_response(["You can not create company"], '', :unprocessable_entity)
	  end
  end

  def destroy
    @company.destroy
  end

  def update
    @company.update_attributes(company_params)
  	json_response(@company, "company updated")
  end

  private

  def company_params
  	params.require(:company).permit(:name, :country_of_incorporation, :currency_used)
  end

  def set_company
  	@company = Company.find(params[:id])
  end

end
