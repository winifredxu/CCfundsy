class CampaignsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_campaign, only: [:show]
  before_action :find_own_campaign, only: [:edit, :update, :destroy]

  def new
    @campaign = Campaign.new
#    render nothing:true

    #3.times { @campaign.reward_levels.build(quantity: 100) } # .build creates an empty associated record in memory
    1.times { @campaign.reward_levels.build }
  end

  def create
    service = Campaigns::CreateCampaign.new(params: campaign_params, user: current_user)

    # @campaign = Campaign.new campaign_params
    # @campaign.user = current_user

    # if @campaign.save
#    render nothing:true
    if service.call
      @campaign = service.campaign
      redirect_to campaign_path(@campaign), notice: "campaign created successfully."
    else
      @campaign = service.campaign
      1.times { @campaign.reward_levels.build }
      flash[:alert] = "campaign failed to create"
      render :new
    end
  end

  def show
    # before_action took care of finding the correct campaign.id object
#    render nothing:true

    respond_to do |format|
      format.html { render }
      format.json { render json: @campaign.to_json }
    end
  end

  def index
    @entire_campaigns = Campaign.published #only show "published" campaigns
    #@entire_campaigns = Campaign.all
    @recent_campaigns = Campaign.published.recent(3)

#    render nothing:true
  end

  def edit
    #calculate how many of the remaining of the 3 blank rewards to be allowed to be filled.
    remaining = 3 - @campaign.reward_levels.count
    remaining.times { @campaign.reward_levels.build }
#    render nothing:true
  end

  def update
    if @campaign.update campaign_params
#    render nothing:true
      redirect_to campaign_path(@campaign), notice: "campaign updated successfully"
    else
      flash[:alert] = "campaign failed to update"
      render :edit
    end
  end

  def destroy
    @campaign.destroy
    redirect_to campaigns_path, notice: "campaign deleted successfully"
#    render nothing:true
  end

  private

  def find_own_campaign
#    @campaign = current_user.campaigns.find params[:id]
    @campaign = current_user.campaigns.find(params[:id]).decorate
    redirect_to root_path unless @campaign
  end
  def find_campaign
    # @campaign = Campaign.find(params[:id])  #try a bigger but less query counts. optimization
#    @campaign = Campaign.includes(:comments, :reward_levels).references(:comments, :reward_levels).find(params[:id])
    @campaign = Campaign.includes(:comments, :reward_levels).references(:comments, :reward_levels).find(params[:id]).decorate
  end
  def campaign_params
    params.require(:campaign).permit(:title, :description, :goal, :due_date,
                                    #we don't actually store notify_admin to DB 
                                    :notify_admin,
                                    {category_ids: []}, 
                                    { reward_levels_attributes: 
                                      [:id, :title, :amount, 
                                       :quantity, :body,
                                       :_destroy ] }
                                    )
  end
end