class UsersController < ApplicationController

  def new
    @user = User.new
#    render nothing: true
  end

  def create
    @user = User.new user_params
    if @user.save
#    render nothing:true    
      redirect_to root_path, notice: "created user account successfully."
    else
      flash[:alert] = "user account not created"
      render :new
    end
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name,
                                  :email, :password, 
                                  :password_confirmation)
  end
end
