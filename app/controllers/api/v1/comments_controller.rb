class Api::V1::CommentsController < ApiController

  def index
    page = Page.find_by(url: url)
    comments = page.comments
    render json: comments
  end

  private

    def url
      request.headers.env.detect{|k, _| k =~ /^HTTP_URL/}[1]
    end
end
