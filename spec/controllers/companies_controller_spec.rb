require 'rails_helper'
require 'devise/jwt/test_helpers'

describe CompaniesController do

  describe "GET 'index' " do
    let(:user) {FactoryGirl.create(:user, email: 'testuser@gmail.com', password: 11223344, name: 'test user', role: 'teacher')}
    it "returns a successful 200 response" do
      get :index, format: :json
      expect(response).to be_success
    end

    it "returns all the companies" do
      FactoryGirl.create_list(:company, 5, user_id: user.id)
      get :index, format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['data'].length).to eq(5)
    end
  end

  describe "GET 'show' " do
    let(:user) { FactoryGirl.create(:user, email: 'testuser@gmail.com', password: 11223344, name: 'test user', role: 'teacher') }
    it "returns a successful 200 response" do
      company = FactoryGirl.create(:company, name: 'company 2', country_of_incorporation: 'test country of incorporation 2', currency_used: 'USD', user: user)
      get :show, params: { id: company.id, format: :json }
      expect(response).to be_success
    end

    it "returns data of an single company" do
      company = FactoryGirl.create(:company, name: 'company 2', country_of_incorporation: 'test country of incorporation 2', currency_used: 'USD', user: user)
      get :show, params: { id: company, format: :json }
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['data']).to_not be_nil
    end

    it "returns an error if the company does not exist" do
      company = FactoryGirl.create(:company, name: 'company 2', country_of_incorporation: 'test country of incorporation 2', currency_used: 'USD', user: user)
      get :show, params: { id: 20, format: :json }
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["data"]["message"]).to eq("Couldn't find Company with 'id'=20")
    end
  end


  describe "POST /api/v1/bathrooms" do
    context "with valid parameters" do
      let(:valid_params) do
        {
           company: {
            name: "test company",
            country_of_incorporation: "Country of incorporation",
            currency_used: "USD",
            user_id: 2
          }
        }
      end

      it "only user can create Company" do
        user =  FactoryGirl.create(:user, email: 'testuser1@gmail.com', password: 11223344, name: 'test user', role: 'student')
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
        request.headers.merge!(auth_headers)
        expect { post "create", params: valid_params}.to change(Company, :count).by(1)
        expect(response).to be_success
        expect(response).to have_http_status 200
      end

      it "teacher can not create Company" do
        user =  FactoryGirl.create(:user, email: 'testuser1@gmail.com', password: 11223344, name: 'test user', role: 'teacher')
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
        request.headers.merge!(auth_headers)
        post "create", params: valid_params
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["errors"]).to eq(["You can not create company"])
        expect(response).to be_success
        expect(response).to have_http_status 200
      end
    end
  end

  describe 'DELETE #destroy' do
	  context "success" do  
	  	let(:user) { FactoryGirl.create(:user, email: 'testuser@gmail.com', password: 11223344, name: 'test user', role: 'teacher') }
	    it "deletes the company" do
	  	company = FactoryGirl.create(:company, name: 'company 2', country_of_incorporation: 'test country of incorporation 2', currency_used: 'USD', user: user)
	      expect{ 
	        delete :destroy, params: { id: company.id, format: :json }
	     }.to change(Company, :count).by(-1)
	    end
	  end
	end

	describe "Update Company" do
		let(:user) { FactoryGirl.create(:user, email: 'testuser@gmail.com', password: 11223344, name: 'test user', role: 'teacher') }
	  it "allows company to be updated" do
	  	company = FactoryGirl.create(:company, name: 'company 2', country_of_incorporation: 'test country of incorporation 2', currency_used: 'USD', user: user)
	    put :update,params: { :id => company.id, :company => company.attributes = { :name => "updated name of company", :currency_used => "Euro" }}
	    response.should be_successful
	  end
	end
end