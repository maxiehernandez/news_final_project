require 'twitter'
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
        p t.urls.to_a
        p "xXXXXXXXXXXXXXXXXXXXXXXX"
        p t.urls[0]
        # if (t.retweet_count.nil? || t.retweet_count > 10) # deletes tweets with less than 10 retweets
        # Soc_med.create(tweeters_id: t.user.id,
        #               t_id: t.id,
        #               favorites: t.favorite_count,
        #               retweets: t.retweet_count,
        #               text: t.text,
        #               hashtags: t.hashtags.to_s,
        #               mentions: t.user_mentions,
        #               urls: t.url.to_s,
        #               followers: nil, #delete
        #               screen_name: nil, #delete
        #               friends: nil, #delete
        #               rank: nil) #delete
        # end
      end
    end

    def build_story
      Soc_med.last(20).each do |tweet|
        Story.create(body: "<a href='https://twitter.com/#{tweet[:tweeters_id]}/status/#{tweet[:t_id]}'></a>", topic_id: 13, story_type: "TW")
      end
    end


  end
end
