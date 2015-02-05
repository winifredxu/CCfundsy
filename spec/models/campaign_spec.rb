require 'rails_helper'

RSpec.describe Campaign, type: :model do
  describe "Validations" do

    def campaign_attributes(new_attributes)
      valid_attributes = {title: "valid title", description: "valid description", 
                          goal: 1000000, due_date: (Time.now + 10.days)}
      valid_attributes.merge(new_attributes)
    end
      
    it "requires a title" do
      campaign = Campaign.new(campaign_attributes({title: nil}))
      expect(campaign).to be_invalid
    end

    it "requires a description" do
#      campaign = Campaign.new
#      campaign = Campaign.new(title: "abcdef")
      campaign = Campaign.new(campaign_attributes({description: nil}))
      expect(campaign).to be_invalid
    end

    it "requires goal must be $10 or more" do
      campaign = Campaign.new(campaign_attributes({goal: 3}))
      expect(campaign).to be_invalid
    end

    it "requires title to be unique" do
      campaign1 = Campaign.create(campaign_attributes( {title: "unique_test", description: "blah1"} ))
      campaign2 = Campaign.new(campaign_attributes( {title: "unique_test", description: "blah1"} ))
      expect(campaign2).to be_invalid
    end


  end

end
