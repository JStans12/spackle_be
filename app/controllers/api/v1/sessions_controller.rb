class Api::V1::SessionsController < ApiController

  def new
    user = User.find_by(name: name)
    if user && user.authenticate(password)
      render json: user
    else
      render json: { failure: "bad credentials" }, status: 400
    end
  end

  private

    def name
      request.headers.env.detect{|k, _| k =~ /^HTTP_NAME/}[1]
    end

    def password
      request.headers.env.detect{|k, _| k =~ /^HTTP_PASSWORD/}[1]
    end
end
