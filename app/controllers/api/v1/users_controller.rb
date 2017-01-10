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
      render json: "account created"
    else
      render json: error(user, user_params), status: 400
    end
  end

  private

    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end

    def error(user, params)
      return "passwords don't match" if params['password'] != params['password_confirmation']
      return "email #{user.errors.messages[:email][0]}" if user.errors.messages.has_key?(:email)
      return "username #{user.errors.messages[:name][0]}" if user.errors.messages.has_key?(:name)
      return ""
    end
end
