class RssFeedsController < ApplicationController
  def create
    @rss_feed = RssFeed.new(rss_feed_params)

    @rss_feed.save
    redirect_to '/dashboard'
  end

  private
  def rss_feed_params
    params.require(:rss_feed).permit(:url)
  end
end
