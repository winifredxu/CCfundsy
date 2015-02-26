class Campaigns::CreateCampaign

  include Virtus.model #to use the Virtus gem for the Service object

  # input objects
  attribute :params, Hash
  attribute :user, User
  # output objects
  attribute :campaign, Campaign

  def call
    @campaign = Campaign.new params
    @campaign.user = user
    @campaign.save
  end

  private

  def send_email_to_admin
    #write the mailer here, insert code here. 
  end
end