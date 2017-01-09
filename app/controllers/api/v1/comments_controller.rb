class Api::V1::CommentsController < ApiController

  def create
    user = User.find(params[:user_id])
    page = Page.find_or_create_by(url: url)
    parent = Comment.find(params[:parent_id]) if params[:parent_id].to_i > 0
    body = HtmlSanitizer.no_html(params[:body])
    if user && user.token == params[:token]
      user.comment(body, page, parent)
      render json: { success: "comment created" }
    else
      render json: { failure: "invalid credentials" }, status: 400
    end
  end

  def update
    user = User.find(params[:user_id])
    comment = Comment.find(params[:comment_id])
    body = HtmlSanitizer.no_html(params[:body])
    if user && user.token == params[:token] && user.comments.include?(comment)
      comment.update(body: body)
      render json: { success: "comment updated" }
    else
      render json: { failure: "invalid credentials" }, status: 400
    end
  end

  def destroy
    user = User.find(params[:user_id])
    comment = Comment.find(params[:comment_id])
    body = HtmlSanitizer.no_html(params[:body])
    if user && user.token == params[:token] && user.comments.include?(comment)
      comment.update(user_id: 1, body: "deleted") unless comment.children.empty?
      comment.destroy                             if comment.children.empty?
      render json: { success: "comment updated" }
    else
      render json: { failure: "invalid credentials" }, status: 400
    end
  end

  private

    def url
      request.headers.env.detect{|k, _| k =~ /^HTTP_URL/}[1]
    end
end
