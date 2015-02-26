class PledgesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_reward_level

  def new
    @pledge = Pledge.new amount: @reward_level.amount
  end

  def create
    @pledge = Pledge.new pledge_params
    @pledge.user = current_user
    @pledge.reward_level = @reward_level

    if @pledge.save
      #redirect_to new payment page
      redirect_to new_pledge_payment_path(@pledge)
    else
      render :new
    end
  end

  def index
    @entire_pledges = @reward_level.pledges.all
  end

  def destroy
    @pledge = Pledge.find params[:id]
    if @pledge.destroy

    end
  end

  private

  def find_reward_level
    @reward_level = RewardLevel.find params[:reward_level_id]
  end
  def pledge_params
    params.require(:pledge).permit(:amount)
  end
end
