class Api::V1::SessionsController < ApiController

  def create
    user = User.find_by(name: params["name"])
    if user && user.confirmed? && user.authenticate(params["password"])
      render json: user
    else
      render json: { failure: "bad credentials" }, status: 400
    end
  end
end
