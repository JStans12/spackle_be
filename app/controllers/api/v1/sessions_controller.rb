class Api::V1::SessionsController < ApiController

  def create
    user = User.find_by(name: params["name"])
    if user && user.confirmed? && user.authenticate(params["password"])
      render json: user
    else
      render json: errors(user), status: 400
    end
  end

  private

    def errors(user)
      return "email is not comfirmed" if user && !user.confirmed?
      return "invalid credentials"
    end
end
