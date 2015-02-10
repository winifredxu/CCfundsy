class CampaignsController < ApplicationController
  before_action :find_campaign, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new]
  
  def new
    @campaign = Campaign.new
#    render nothing:true
  end

  def create
    @campaign = Campaign.new campaign_params
    if @campaign.save
#    render nothing:true
      redirect_to campaigns_path(@campaign), notice: "campaign created successfully."
    else
      flash[:alert] = "campaign failed to create"
      render :new
    end
  end

  def show
    # before_action took care of finding the correct campaign.id object
#    render nothing:true
  end

  def index
    @entire_campaigns = Campaign.all
#    render nothing:true
  end

  def edit
#s    render nothing:true
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

  def find_campaign
    @campaign = Campaign.find(params[:id])
  end
  def campaign_params
    params.require(:campaign).permit(:title, :description, :goal, :due_date)
  end
end
