class Api::V1::UpsController < ApiController

  def create
    user    = User.find(params[:user_id])
    comment = Comment.find(params[:comment_id])
    if user && user.token == params[:token]
      up = user.ups.find_or_create_by(comment_id: comment.id)

      if up.value == params[:value].to_i
        up.update(value: 0)
      else
        up.update(value: params[:value].to_i)
      end

      render json: "vote tallied"
    else
      render json: "invalid credentials", status: 400
    end
  end
end
