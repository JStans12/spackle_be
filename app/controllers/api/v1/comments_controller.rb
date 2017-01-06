class Api::V1::CommentsController < ApiController

  def index
    page = Page.find_by(url: url)
    comments = page.base_comments.by_score
    render json: comments
  end

  def create
    user = User.find_by(token: params[:user_id])
    page = Page.find_or_create_by(url: url)
    parent = Comment.find(params[:parent_id]) if params[:parent_id].to_i > 0
    body = params[:body]
    if user
      user.comment(body, page, parent)
      render json: "success"
    else
      render json: "failure", status: 400
    end
  end

  private

    def url
      request.headers.env.detect{|k, _| k =~ /^HTTP_URL/}[1]
    end
end
