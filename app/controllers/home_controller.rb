class HomeController < ApplicationController
  def index
    @feed_urls = FeedUrl.where(is_open: true).paginate(page: params[:page])
  end
end
