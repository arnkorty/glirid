class HomeController < ApplicationController
  def index
    @feed_urls = FeedUrl.open.paginate(page: params[:page])
  end
end
