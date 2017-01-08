class Api::V1::PagesController < ApiController

  def show
    page = Page.find_by(url: url)
    render json: page
  end

  private

    def url
      request.headers.env.detect{|k, _| k =~ /^HTTP_URL/}[1]
    end
end
