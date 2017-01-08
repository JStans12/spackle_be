class Api::V1::CommentsController < ApiController

  def create
    user = User.find(params[:user_id])
    page = Page.find_or_create_by(url: url)
    parent = Comment.find(params[:parent_id]) if params[:parent_id].to_i > 0
    body = HtmlSanitizer.no_html(params[:body])
    if user && user.token == params[:token]
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
