class NewsRssesController < ApplicationController
  def new
    @news_rss = News_rss.new
  end

  def create
    @news_rss = News_rss.create(news_rss_params)
  end


private
  def news_rss_params
    params.require(:news_rss).permit(:source_id, :source_name, :pub_date, :story_id, :headline, :url, :pic_url, :keywords, :summary)
  end
end
