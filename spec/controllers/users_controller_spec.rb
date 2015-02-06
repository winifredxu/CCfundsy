require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "#new" do
    it "assigns a new user instance variable" do
      get :new # HTTP method 'get' with action 'new'
      expect(assigns(:user)).to be_a_new(User)  #syntax explanation: @user should be User.new
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)  #Rspec 'matchers' 
    end
  end

  describe "#create" do

    context "valid request" do
      def valid_request
        post :create, {user: {first_name: "Jane",
                              last_name:  "Golden",
                              email: "jane@blah.ca",
                              password: "1234",
                              password_confirmation: "1234"} }
      end

      it "creates a new user record in the database" do
        expect { valid_request }.to change { User.count }.by(1)
      end

      it "redirect to homepage" do
        valid_request
        expect(response).to redirect_to(root_path) 
      end

      it "sets flash message" do
        valid_request
        expect(flash[:notice]).to be
      end
    end

    context "invalid request" do
      def invalid_request
        post :create, {user: {first_name: "Jane",
                              last_name:  "Golden",
                              email: "blah_bad_email", #invalid email format
                              password: "1234",
                              password_confirmation: "1234"} }
      end

      it "doesn't create a record in the database" do
        expect { invalid_request }.not_to change { User.count }
      end   # will pass since we have model param validation, but remove that and make it fail at least once. 

      it "sets a flash errors message" do
        invalid_request
        expect(flash[:alert]).to be
      end

      it "renders the new user template page" do
        invalid_request
        expect(response).to render_template(:new)
      end
    end

  end

end
