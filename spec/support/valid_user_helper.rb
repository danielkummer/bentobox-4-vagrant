module ValidUserHelper
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in Fabricate(:admin) # Using factory girl as an example
    end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:users]
      @user = Fabricate(:user)
      sign_in @user
    end
  end
end

