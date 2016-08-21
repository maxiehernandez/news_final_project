class Soc_med < ApplicationRecord
  validates :t_id, uniqueness: true

  def self.build_new_topic
    tags = count_hashtags(flatten_tags(gather_tweet_hashtags))
    tags.delete_if {|key, value| value <= 50 }
    tags = tags.keys
    p tags
    # p "got it"
    if tags != nil
      tags.each do |tag|
        Topic.create!(slug: tag) unless Topic.find_by slug: tag
        Soc_med.all.each do |search|
          # puts search.hashtags
          if search.hashtags.include?(tag)
            Story.create(body: "<a href='https://twitter.com/#{search.tweeters_id}/status/#{search.t_id}' target='_$'></a>",
              topic_id: Topic.friendly.find(tag).id,
              story_type: "TW")
              # p "done"
          end
        end
        News_rss.all.each do |news_search|
          if (news_search.headline.include?(tag))
            @story = Story.create!(body: "<div class='media'><div class='media-body'><h2 class='media-heading'><a href='#{news_search.url}' target='_$'>#{news_search.headline}</a></h2><p>#{news_search.source_name}</p> <p>#{news_search.pub_date}</p></div><div class='media-left'><a href='#{news_search.url}' target='_$'><img class='media-object' src='#{news_search.pic_url}'></a></div></div>", topic_id: Topic.friendly.find(tag).id, story_type: "RS")
          end
        end
      end
    end
  end

    def self.top_retweets #sorts Soc_media by number of retweets and returns top ten
      top_ten_tweets = []
      rt = Soc_med.all.sort_by {|t| t.retweets}.reverse
      top_ten_tweets = rt.first(10)
        return top_ten_tweets
    end

    def self.top_favorites #sorts Soc_media by number of retweets and returns top ten
      top_ten_tweets = []
      fv = Soc_med.all.sort_by {|t| t.favorites}.reverse
      top_ten_favorites = fv.first(10)
        return top_ten_favorites
    end

    def self.build_favorite_tweet_stories#builds top ten rewteeted tweets into stories with a "TW10" type
      top_fav_tweets = top_favorites
      top_fav_tweets.each do |x|
        Story.create!(
        body: "<a href='https://twitter.com/#{x[:tweeters_id]}/status/#{x[:t_id]}'></a>",
        topic_id: Topic.friendly.find('trending').id,
        story_type: "TWFV")
      end
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

    def self.build_new_hotness
      Soc_med.all.each do |hotness|
        if (hotness.urls != nil)
          News_rss.all.each do |story|
            if hotness.urls == story.url
              Story.create(body: "<div class='media'><div class='media-body'><h2 class='media-heading'><a href='#{story.url}'>#{story.headline}</a></h2><p>#{story.source_name}</p> <p>#{story.pub_date}</p></div><div class='media-left'><a href='#{story.url}'><img class='media-object' src='#{story.pic_url}'></a></div></div>", topic_id: Topic.friendly.find('trending').id, story_type: "RSNH")
            end
          end
        end
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
      blacklist = %w[headlines your team watch first their out can state trump away it's but if up or do his been if it a no being had as after from like are they our powertv her only day have when need dont don't via him get most really will us my there by she at has me what so etc of a i in you for and with to this on to he amp more we powertv Powertv PowerTV just im who people http https that not be an was rt is about the]  # creates blacklisted words
      blacklist.each do |blacklisted|  #deletes blacklisted words
        sorted.delete_if {|key, value| key == blacklisted}
      end
      return sorted
    end

    def self.get_top_words(cleaned_and_sorted)
      cleaned_and_sorted[0...19]
      # p "The Top 20 Keywords in tweets are #{cleaned_and_sorted}"
      return cleaned_and_sorted
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
      x.each { |tag| freq[tag] += 1 }
      freq
      return freq  #returns hash with freq
    end

    def self.get_top_tags(sorted_tags)
       sorted_tags = sorted_tags[0...20]
      # p "The top 10 Hashtags are #{top_tags}"
      return sorted_tags  #returns an array of top ten Tweet
    end

    def self.top_tweet_hashtags #search for top hashtags in tweets
      get_top_tags(
      remove_blacklisted_from_text(
                sort_words(
                count_hashtags(
                flatten_tags(
                gather_tweet_hashtags))  )))
    end
  ################################### end hashtag methods##################################

  def self.build_story_top_tweet_links
    Story.create!(
    body: "<a href='https://twitter.com/#{x[:tweeters_id]}/status/#{x[:t_id]}'></a>",
    topic_id: Topic.friendly.find('trending').id,
    story_type: "TW10")
  end

  def self.gather_twitter_links #creates array of links from captured tweets
    i = 0
    urls_to_count = []
      Soc_med.all.each do |x|
       txt = x[:urls].to_s
       re1='.*?'    # Non-greedy match on filler
       re2='((?:http|https)(?::\\/{2}[\\w]+)(?:[\\/|\\.]?)(?:[^\\s"]*))'   # HTTP URL 1
       re=(re1+re2)
       m=Regexp.new(re,Regexp::IGNORECASE);
        if m.match(txt)
          httpurl1=m.match(txt)[1];
          y = httpurl1
         urls_to_count << y
       end
      end
      return urls_to_count
  end

  def self.count_tw_links(urls_to_count)  #method to count words
    links = urls_to_count
    # p "LINKS #{links}"
    freq = Hash.new(0)
    links.each { |word| freq[word.downcase] += 1 }
    # p "FREQ #{freq}"
    return freq  #returns hash with freq
  end

  def self.sort_tw_links(freq)     #creates has of indv words with wordcount
    sorted = freq.sort_by {|k,v| v}.reverse # builds sorted array with highest first
    # p "SORTED #{sorted}"
    return sorted
  end

  def self.top_tw_links(sorted_links) #returns an array of top ten Twitter links
    # p "BEFORE sorted links #{sorted_links}"
    top_links = []
    top_links << sorted_links[0...9]
    # p "The top 10 Twitter links are #{top_links}"
    top_links = top_links
    top_links.to_a.each do |x|
      # p x[0]
    end

    return top_links  #returns an array of top ten Twitter links
  end

  def self.get_top_tw_links #search for links in twitter feed
    top_tw_links(
      sort_tw_links(
      count_tw_links(
      gather_twitter_links)))
  end
end
