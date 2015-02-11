require 'rails_helper'

RSpec.feature "Campaigns", type: :feature do
  let(:user) { create(:user) }

  describe "Home page / Listing Campaigns" do
    it "displays a welcome message" do
      visit root_path #visit campaigns_path
      expect(page).to have_text "Welcome to Fundsy"      
    end

    it "displays a title for the page" do
      visit root_path
      expect(page).to have_title "Fundsy Crowd Funding"
    end
 

    context "with campaigns" do
      let!(:campaign) { create(:campaign) }
      let!(:campaign_1) { create(:campaign) }
     
      it "displays campaign's title" do
        visit root_path
        expect(page).to have_text /#{campaign.title}/i
      end
      it "displays campaign titles in h2 elements" do
        visit root_path
        # opens  the current page in the browser, requires the gem 'launchy'
#        save_and_open_page  #feature in gem 'launchy' that works with 'capybara' 
        expect(page).to have_selector "h2", campaign_1.title
      end
      
    end
  end

  describe "Creating a campaign" do
    it "creates a campaign and redirects to show page" do
      login_via_web(user)
      visit new_campaign_path
#      save_and_open_page

      attrs = attributes_for :campaign #loads valid attributes from FactoryGirl
      fill_in "Title", with: attrs[:title]
      fill_in "Description", with: attrs[:description]
      fill_in "Goal", with: attrs[:goal]

      click_button "Submit"

      expect(current_path).to eq(campaign_path(Campaign.last))
      expect(Campaign.count).to eq(1)
      expect(page).to have_text /Campaign created successfully./i

    end

  end
end