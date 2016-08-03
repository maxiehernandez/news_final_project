require 'rss'

class RSSUtilities
  class << self

    def rss_urls
      @rss_urls ||= RssFeed.all.map(&:url)
    end

    def all_rss_feeds
      @all_rss_feeds ||= rss_urls.map { |rss_url| RSS::Parser.parse(rss_url, false) }.flatten
    end
    # memoizing used to set an instance variable one time

    def all_rss_feed_items
      @all_rss_feed_items ||= all_rss_feeds.map(&:items).flatten
    end
    # flatten is takes one element if there are arrays inside of arrays

    def save_rss_stories
      all_rss_feed_items.each do |item|
        News_rss.create(pub_date: "#{item.pubDate}",
                        headline: "#{item.title}",
                        url: "#{item.link}")
      end
    end
  end
end
