class Soc_med < ApplicationRecord
  validates :t_id, uniqueness: true
  ###############################TOP Retweets Methods Begin##################################
    def self.top_retweets #sorts Soc_media by number of retweets and returns top ten
      top_ten_tweets = []
      rt = Soc_med.all.sort_by {|t| t.retweets}.reverse
      top_ten_tweets = rt.first(10)
        return top_ten_tweets
    end

    def self.build_top_tweet_stories#builds top ten rewteeted tweets into stories with a "TW10" type
      top_ten_tweets = top_retweets
      top_ten_tweets.each do |x|
        Story.create!(
        body: "<a href='https://twitter.com/#{x[:tweeters_id]}/status/#{x[:t_id]}'></a>",
        topic_id: Topic.friendly.find('trending').id,
        story_type: "TW10")
      end
    end
  ###############################TOP Keywords in Tweets Methods Begin##################################
    def self.gather_tweet_array #creates array of tweet text
      i = 0
      text_to_search = []
      things = Soc_med.all
      while i < things.length
        text_to_search << things[i].text
        i += 1
      end
      return text_to_search
    end

    def self.flatten_text(text_to_search)
      y = text_to_search
      y = y.join(", ").gsub!(/[[:punct:]]/, '') # flattens array into one string based on commas and removes punctuation from inside array
      return y
    end

    def self.count_words(uncounted_words)  #method to count words
      words = uncounted_words.split(' ')
      freq = Hash.new(0)
      words.each { |word| freq[word.downcase] += 1 }
      return freq  #returns hash with freq
    end

    def self.sort_words(stuff)     #creates has of indv words with wordcount
      sorted = stuff.sort_by {|k,v| v}.reverse # builds sorted array with highest first
      return sorted
    end

    def self.add_blacklist_word(word)
     blacklist = %w[rt is about the]  # creates blacklisted words
     blacklist << word
    end

    def self.remove_blacklisted_from_text(sorted)
      blacklist = %w[headlines can away it's but if up or do his been if it a no being had as after from like are they our powertv her only day have when need dont don't via him get most really will us my there by she at has me what so etc of a i in you for and with to this on to he amp more we just im who people http https that not be an was rt is about the]  # creates blacklisted words
      blacklist.each do |blacklisted|  #deletes blacklisted words
        sorted.delete_if {|key, value| key == blacklisted}
      end
      return sorted
    end

    def self.get_top_words(cleaned_and_sorted)
      top_words = [].flatten
      top_words << cleaned_and_sorted[0...19]
      p "The Top 20 Keywords in tweets are #{top_words}"
      return top_words
    end

    def self.top_tweet_keywords # search for top keywords in tweets
      get_top_words(
      remove_blacklisted_from_text(
                sort_words(
                count_words(
                flatten_text(
                gather_tweet_array)))))
    end
  ################################Top Keywords in tweets end##################################
  ################################# Top Hashtag in Tweet methods##################################

    def self.gather_tweet_hashtags #creates array of tweet hashtags
      i = 0
      tags = []
      things = Soc_med.all
      while i < things.length
        tags << things[i].hashtags
        i += 1
      end
      return tags
    end

    def self.flatten_tags(tags)
      y = tags.flatten
      y = y.join("#").gsub!(/[[:punct:]]/, " ") # flattens array into one string based on hashtags
      uncounted_hashtags = y.split(" ")
      # puts uncounted_hashtags
      # p uncounted_hashtags
      return uncounted_hashtags
    end

    def self.count_hashtags(uncounted_hashtags)  #method to count words
      x= uncounted_hashtags
      # p hashtags
      freq = Hash.new(0)
      x.each { |tag| freq[tag.downcase] += 1 }
      freq
      return freq  #returns hash with freq
    end

    def self.get_top_tags(sorted_tags)
       sorted_tags = sorted_tags[0...9]
      # p "The top 10 Hashtags are #{top_tags}"
      return sorted_tags  #returns an array of top ten Tweet
    end
    def self.top_tweet_hashtags #search for top hashtags in tweets
      get_top_tags(
                sort_words(
                count_hashtags(
                flatten_tags(
                gather_tweet_hashtags))))
    end
  ################################### end hashtag methods##################################
end
