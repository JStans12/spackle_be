class Api::V1::UsersController < ApiController

  def me
    user = User.find_by(token: token)
    render json: user
  end

  private

    def token
      request.headers.env.detect{|k, _| k =~ /^HTTP_TOKEN/}[1]
    end
end
