module ControllerMacros
  def login_account account
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:account]
      #user = FactoryGirl.create(:account)
      # user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in account
    end
  end

  def login!
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:account]
      account = FactoryGirl.create(:account)
      # user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in account
    end
  end
end
