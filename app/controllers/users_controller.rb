class UsersController < ApplicationController

  def new
    @user = User.new
#    render nothing: true
  end


end
