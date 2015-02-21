require 'rails_helper'
RSpec.describe SessionsController, type: :controller do
  let(:user) { create(:user) }  #use FactoryGirl to build test users
  describe "#new" do
    it "sets a new user instance" do
      get :new
      expect(assigns(:user)).to be_a_new(User)  #syntax explanation: @user should be User.new      
    end
    it "renders a new page" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    context "successful login" do
      def valid_request
        post :create, user: { email: user.email, 
                              password: user.password }
      end
      it "sets user_id session variable" do
        valid_request
        expect(session[:user_id]).to eq(user.id)
      end
      it "redirect_to homepage" do
        valid_request
        expect(response).to redirect_to(root_path)
      end
      it "sets a flash message" do
        valid_request
        expect(flash[:notice]).to be
      end
    end
    context "unsuccessful login" do
      def invalid_request
        post :create, user: { email: user.email, 
                              password: user.password + "x" }
      end
      it "doesn't set the session user_id variable" do
        invalid_request
        expect(session[:user_id]).not_to be
      end
      it "renders the new template" do
        invalid_request
        expect(response).to render_template(:new)
      end
      it "create a flash alert message" do
        invalid_request
        expect(flash[:alert]).to be
      end
    end
  end

  describe "#destroy" do
    before do
      login(user)
      delete :destroy
    end
    it "removes the session user_id variable" do
      expect(session[:user_id]).not_to be
    end
    it "redirect_to the homepage" do
      expect(response).to redirect_to(root_path)
    end
    it "sets a flash message" do
      expect(flash[:notice]).to be
    end
  end

end
