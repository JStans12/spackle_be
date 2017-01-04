class Api::V1::UsersController < ApiController

  def me
    user = User.find_by(token: token)
    render json: user
  end

  def create
    user = User.new(user_params)
    if user.save
      # send confirmation email
      # render success json
    else
      #render fail json
    end
  end

  private

    def token
      request.headers.env.detect{|k, _| k =~ /^HTTP_TOKEN/}[1]
    end

    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end
end
