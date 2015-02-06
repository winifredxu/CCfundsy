require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do

  let(:campaign) { create(:campaign) }
  let(:campaign_2) { create(:campaign) } 
# def let
#   create(:campaign)
# end

  describe "#new" do 
    it "assigns a new user instance variable" do
      get :new
      expect(assigns(:campaign)).to be_a_new(Campaign)
    end
      
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do

    context "valid_campaign_request" do
      def valid_campaign_request
        post :create, {campaign: {title: "first", 
                                  description: "blah blah blah",
                                  goal: 15,
                                  due_date: (Time.now + 10.days)} } 
      end
      it "adds a campaign to the database" do
        expect { valid_campaign_request }.to change { Campaign.count }.by(1)
      end

      it "redirect to campaign new page" do
        valid_campaign_request
        expect(response).to redirect_to(campaigns_path(Campaign.last))
      end

      it "sets flash message" do
        valid_campaign_request
        expect(flash[:notice]).to be
      end
    end

    context "invalid_campaign_request" do
      def invalid_campaign_request
        post :create, {campaign: {title: "first", 
                                  description: "blah blah blah",
                                  goal: 3,  # goal has to be more than 10
                                  due_date: (Time.now + 10.days)} }
      end
      it "doesn't create a record in the database" do
        expect { invalid_campaign_request }.not_to change { Campaign.count } 
      end

      it "sets a flash errors message" do
        invalid_campaign_request
        expect(flash[:alert]).to be
      end

      it "renders the new campaign template page" do
        invalid_campaign_request
        expect(response).to render_template(:new)
      end
    end
    
  end

  describe "#show" do #use Factories to create objects for our tests (FactoryGirl)
    it "assigns a campaign instance variable with passed id" do
#      c = FactoryGirl.create(:campaign)  #add a line in rspec/rails_helper.rb file
#      c = create(:campaign)
      get :show, id: campaign.id
      expect(assigns(:campaign)).to eq(campaign)
    end

    it "renders the show template" do
#      c = FactoryGirl.create(:campaign)  #add a line in rspec/rails_helper.rb file
#      c = create(:campaign)
      get :show, id: campaign.id
      expect(response).to render_template(:show)
    end
  end

  describe "#index" do
    it "assigns campaigns instance variable to create campaigns" do
      campaign
      campaign_2
      get :index
      expect(assigns(:entire_campaigns)).to eq([campaign, campaign_2])
    end

    it "render the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "#edit" do
    before do
      get :edit, id: campaign.id 
    end      
    it "renders the edit template" do
      expect(response).to render_template(:edit)
    end

    it "retrieves the campaign with passed ID and stores it in instance variable " do
      expect(assigns(:campaign)).to eq(campaign)
    end
  end

  describe "#update" do
    context "with valid request" do
      before do
        patch :update, id: campaign.id, campaign: {title: "new title"}
      end

      it "redirect to the campaign show page" do
        expect(response).to redirect_to(campaign_path(campaign))
      end
      it "changes the title of the campaign if it's different" do
        expect(campaign.reload.title).to eq("new title")
      end
      it "sets a notice flash message" do
        expect(flash[:notice]).to be
      end

    end
    context "with invalid request" do  
      before do
        patch :update, id: campaign.id, campaign: {goal: 3}
      end
      it "renders the edit page" do
        expect(response).to render_template(:edit)
      end
      it "doesn't change the database" do
        #before_reload_goal = campaign.goal

        #make test fail by comment out the validates on goal in campaign.rb model
        expect(campaign.reload.goal).not_to eq(3)
      end
      it "sets an alert flash message" do
        expect(flash[:alert]).to be
      end
    end
  end

  describe "#destroy" do
=begin    
    before do 
      delete :destroy, id: campaign.id
    end
=end
    let!(:campaign_die) { create(:campaign) } 

    it "delete the campaign from the database" do
#      campaign   #create campaign first before expect line so Count is accurate
      expect {
        delete :destroy, id: campaign_die.id
      }.to change { Campaign.count }.by(-1)
    end
    it "redirect to homepage (root path)" do
      delete :destroy, id: campaign.id
      expect(response).to redirect_to(campaigns_path)
    end
    it "sets a flash message when deleted successfully" do
      delete :destroy, id: campaign.id
      expect(flash[:notice]).to be 
    end
  end

end