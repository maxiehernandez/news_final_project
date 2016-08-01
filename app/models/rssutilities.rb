require 'rss'

class RSSUtilities
  class << self
    def fetch
      @cnn_all = RSS::Parser.parse('http://rss.cnn.com/rss/cnn_topstories.rss', false)
      @dem_now = RSS::Parser.parse('http://democracynow.org/democracynow.rss', false)
      @blk_agenda = RSS::Parser.parse('http://blackagendareport.com/rss.xml', false)
    end

    def save_rss_stories
      fetch
      @cnn_all.items.each do |item|
        News_rss.create(pub_date: "#{item.pubDate}",
                        headline: "#{item.title}",
                        url: "#{item.link}")
      end

      @dem_now.items.each do |item|
        News_rss.create(pub_date: "#{item.pubDate}",
                        headline: "#{item.title}",
                        url: "#{item.link}")
      end

      @blk_agenda.items.each do |item|
        News_rss.create(pub_date: "#{item.pubDate}",
                        headline: "#{item.title}",
                        url: "#{item.link}")
      end
    end
  end
end
