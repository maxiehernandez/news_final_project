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

      def save_story
        self.refresh.each do |t|

        Soc_med.create(tweeters_id: t.user.id,
                          t_id: t.id,
                          favorites: t.favorite_count,
                          retweets: t.retweet_count,
                          text: t.text,
                          hashtags: t.hashtags,
                          mentions: t.user_mentions,
                          urls: t.urls,
                          followers: nil,
                          screen_name: nil,
                          friends: nil,
                          rank: nil)
      end
      build_story
    end

    def build_story
      Soc_med.last(10).each do |tweet|
        Story.create(body: "<a href='https://twitter.com/#{tweet[:tweeters_id]}/status/#{tweet[:t_id]}'></a>", topic_id: 13, story_type: "TW")
      end
    end
  end
end
