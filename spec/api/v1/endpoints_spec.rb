require 'rails_helper'

describe Api::V1::PagesController do
  context '/page' do
    it 'returns comments and ups for a url'do
    reddit = Page.create(url: "https://www.reddit.com/")
    user, user2 = create_list(:user, 2)

    comment = user.comment("Hey Reddit!", reddit)
    comment2 = user2.comment("Oh, hey!", reddit, comment)
    user.upvote(comment2)

    get '/api/v1/page', headers: {'HTTP_URL': reddit.url}
    comments = JSON.parse(response.body, symbolize_names: true)[:comments]
    live_comment = comments.first
    live_comment2 = live_comment[:children].first

    expect(comments.length).to eq(1)
    expect(live_comment[:body]).to eq("Hey Reddit!")
    expect(live_comment2[:body]).to eq("Oh, hey!")
    expect(live_comment2[:ups].second[:value]).to eq(1)
    end
  end
end
