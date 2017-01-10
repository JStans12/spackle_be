class UsersController < ApplicationController

  def confirm_email
    @user = User.find(params[:user_id])
    if @user.secret == params[:q]
      @user.confirmed!
    else
      render file: "public/404", layout: false
    end
  end
end
