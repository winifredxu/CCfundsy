require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "#new" dos

    it "assigns a new user instance variable" do
      get :new # HTTP method 'get' with action 'new'
      expect(assigns(:user)).to be_a_new(User)  #syntax explanation: @user should be User.new
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)  #Rspec 'matchers' 
    end



  end

end
