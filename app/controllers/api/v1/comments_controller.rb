class Api::V1::CommentsController < ApiController

  def index
    page = Page.find_by(url: params[:url])
    comments = page.comments
    render json: comments
  end
end
