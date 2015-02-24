class Api::V1::CampaignsController < Api::V1::BaseController
# class Api::V1::CampaignsController < ApplicationController
#   before_action :authorize_access
#   # to bypass CSRF token authenticity issue:
#   skip_before_action :verify_authenticity_token


  def show
    @campaign = Campaign.find params[:id] # show.json.jbuilder
  end

  def index
    @campaigns = Campaign.published
    #render json: @campaigns # index.json.jbuilder in views
  end

  def create 
    #attempt a POST action, and we now need to bypass the CSRF token authenticity issue.
    render json: {}
  end

end