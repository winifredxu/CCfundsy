class SessionsController < ApplicationController
#  before_action :find_user, only: [:destroy]

  def new
    @user = User.new
#    render nothing: true
  end

  def create
    @user = User.find_by_email params[:user][:email]
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to root_path, notice: "#{@user.first_name} Logged in!"
#     render nothing: true
    else
      flash[:alert] = "wrong email or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "you've been logged out"
#    render nothing: true
  end


  private

  def find_user
    @user = User.find(params[:id])
  end
end
