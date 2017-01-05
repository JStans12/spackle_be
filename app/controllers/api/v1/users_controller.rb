require './app/controllers/mailer.rb'

class Api::V1::UsersController < ApiController

  def me
    user = User.find_by(token: params["token"])
    render json: user
  end

  def create
    user = User.new(user_params)
    if user.save
      UserMailer.registration_confirmation(user).deliver
      render json: { success: "account created" }
    else
      render json: { failuer: "account creation failed" }
    end
  end

  def confirm_email
    @user = User.find(params[:user_id])
    if @user.secret == params[:q]
      @user.confirmed!
    else
      render file: "public/404", layout: false
    end
  end

  private

    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end
end
