module ControllerMacros
  # def login_admin
  #   before(:each) do
  #     @request.env["devise.mapping"] = Devise.mappings[:admin]
  #     sign_in FactoryBot.create(:admin) # Using factory bot as an example
  #   end
  # end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      # user = FactoryBot.create(:user)
      let(:user) { FactoryGirl.create(:user, email: 'testuser@gmail.com', password: 11223344, name: 'test user', role: 'teacher') }
      user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in user
    end
  end
end