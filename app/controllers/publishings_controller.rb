class PublishingsController < ApplicationController
  before_action :authenticate_user!

  def create
    campaign = Campaign.find params[:campaign_id]
    campaign.publish!
    # expire caching more frequently than pre-set time frame.
    expire_fragment "recent_campaigns"
    redirect_to campaign, notice: "Campaign published!"
  end
  
end
