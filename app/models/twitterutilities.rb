class TwitterUtilities
  class << self
    def client
      @client ||= Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["CONSUMER_KEY"]
        config.consumer_secret     = ENV["CONSUMER_SECRET"]
        config.access_token        = ENV["ACCESS_TOKEN"]
        config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
      end
    end

    def search(keyword)
      client.search(keyword)
    end

    def refresh
      client.home_timeline(options = {count: 10, exclude_replies: true})
    end

    def build_story
      twitter_feed = TwitterUtilities.refresh
      twitter_feed.each do |tweet|
        Story.create(body: "<p>#{tweet.user.name}</p><p>#{tweet.text}</p><p>#{tweet.id}</p><p>#{tweet.retweet_count}</p>")
      end
    end
  end
end
