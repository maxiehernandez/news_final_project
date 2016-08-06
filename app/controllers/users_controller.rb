require 'twitterutilities'
require 'rssutilities'
require 'feedlr'
require 'nokogiri'

class UsersController < ApplicationController
  # before_action :require_admin, only: :dashboard
  before_action :get_feeds, only: [:dashboard]

  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end

  def home
  end

  def get_feeds
    @news_rss = News_rss.new
    @news_rsses = News_rss.all
    @topic = Topic.new
    @topics = Topic.all
    @story = Story.new
    @stories = Story.all
    @soc_meds = Soc_med.all
    @soc_med = Soc_med.new
    @feedlies = start_feedly
    # TwitterUtilities.save_story  # saves Tweets from Twitter API into Soc_med
    # **USE save FEEDLIES INSTEAD** RSSUtilities.save_rss_stories #saves RSS stories from feeds into News_rss
    # build_story_from_most_retweets #builds stories from top 10 most retweeted tweets
    # top_tweet_hashtags  #returns top ten hashtags to console
    # get_top_tw_links  #gets top twitter links w count
    # top_tweet_hashtags
    # save_feedlies  #and also saves feedly images to News_rss
  end

  def dashboard
    @topics = Topic.order("position")
    @rss_feed = RssFeed.new
  end

  def start_feedly
    client=Feedlr::Client.new(oauth_access_token:'A3J-oq2X2nh2I3eFCVsYh3O3tYvzGUk61ar56b-iZ6ynUANr2w3Xuo3ANgZSWF-9SF1xKgLQ61358YWtyiIz2O8n-gZZquwnBONyBNjSY75katVfqcPagvVPm2tStKf9VbLdZ0F5CnPpg01KpRrmN9QH3H2Whpu2KP1OjuNBz5K8mXIhs3rSPVgrLiMutkA2-mHDVXVYyuneQ-jBgrYUlK564wN1DqEX')
    return client
  end

  def parse_og_image(feed_item)
    url = feed_item.originId
    body = HTTParty.get(url).response.body
    dom = Nokogiri::HTML(body)
    dom.css("meta[id='ogimage']").attribute('content').value
  end

  def save_feedlies
    feeds = @feedlies.user_subscriptions
    feeds.each do |feed_info|
      streams = feed_info.to_h['id']
      stories_per_source = 10
      stories = @feedlies.stream_entries_contents(streams, count: stories_per_source).to_h
      i = 0
      while i < stories_per_source
        News_rss.create(
        source_id: streams,
        source_name: stories['items'].map(&:origin).map(&:title)[i],
        pub_date: stories['items'].map(&:published)[i],
        story_id: stories['items'].map(&:id)[i],
        headline: stories['items'].map(&:title)[i],
        url: stories['items'].map(&:originId)[i],
        summary: stories['items'].map(&:summary).map(&:content)[i],
        keywords: stories['items'].map(&:keywords)[i])
        i += 1
      end
    end
    save_feedly_images
  end

  def save_feedly_images
    @news_rsses. each do |x|
      link = x.url
      body = HTTParty.get(link).response.body
      dom = Nokogiri::HTML(body)
      if dom.css("meta[id='ogimage']").present?
        x.pic_url = dom.css("meta[id='ogimage']").attribute('content').value
        x.save
      end
      # p "no pic for #{x.url}."
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
  end

  def show
  end

  # Editor Search function (incomplete)
  def editor_search
    @results = Soc_med.where text: params[:term]
    redirect_to '/dashboard'
  end

############################################################
#                    DATA ANALYSIS                         #
############################################################
###############################TOP Retweets Methods Begin##################################
  def top_retweets #sorts Soc_media by number of retweets and returns top ten
    top_ten_tweets = []
    rt = @soc_meds.sort_by {|t| t.retweets}.reverse
    rt.first(10).each do |y|
      top_ten_tweets << y
      return top_ten_tweets
    end
  end

  def build_top_tweets_stories #builds top ten rewteeted tweets into stories with a "TW10" type
    top_ten_tweets.each do |x|
      Story.create(
      body: "<a href='https://twitter.com/#{x[:tweeters_id]}/status/#{x[:t_id]}'></a>",
      topic_id: 0,
      story_type: "TW10")
    end
  end

###############################TOP Keywords in Tweets Methods Begin##################################
  def gather_tweet_array #creates array of tweet text
    i = 0
    text_to_search = []
    things = @soc_meds
    while i < things.length
      text_to_search << things[i].text
      i += 1
    end
    return text_to_search
  end

  def flatten_text(text_to_search)
    y = text_to_search
    y = y.join(", ").gsub!(/[[:punct:]]/, '') # flattens array into one string based on commas and removes punctuation from inside array
    return y
  end

  def count_words(uncounted_words)  #method to count words
    words = uncounted_words.split(' ')
    freq = Hash.new(0)
    words.each { |word| freq[word.downcase] += 1 }
    return freq  #returns hash with freq
  end

  def sort_words(stuff)     #creates has of indv words with wordcount
    sorted = stuff.sort_by {|k,v| v}.reverse # builds sorted array with highest first
    return sorted
  end

  def add_blacklist_word(word)
   blacklist = %w[rt is about the]  # creates blacklisted words
   blacklist << word
  end

  def remove_blacklisted_from_text(sorted)
    blacklist = %w[headlines can away it's but if up or do his been if it a no being had as after from like are they our powertv her only day have when need dont don't via him get most really will us my there by she at has me what so etc of a i in you for and with to this on to he amp more we just im who people http https that not be an was rt is about the]  # creates blacklisted words
    blacklist.each do |blacklisted|  #deletes blacklisted words
      sorted.delete_if {|key, value| key == blacklisted}
    end
    return sorted
  end

  def get_top_words(cleaned_and_sorted)
    top_words = []
    top_words << cleaned_and_sorted[0...19]
    p "The Top 20 Keywords in tweets are #{top_words}"
    # return top_ten
  end

  def top_tweet_keywords # search for top keywords in tweets
    get_top_words(
    remove_blacklisted_from_text(
              sort_words(
              count_words(
              flatten_text(
              gather_tweet_array)))))
  end
################################Top Keywords in tweets end##################################

################################# Top Hashtag in Tweet methods##################################
  def gather_tweet_hashtags #creates array of tweet hashtags
    i = 0
    tags = []
    things = @soc_meds
    while i < things.length
      tags << things[i].hashtags
      i += 1
    end
    return tags
  end

  def flatten_tags(tags)
    y = tags.flatten
    y = y.join("#").gsub!(/[[:punct:]]/, " ") # flattens array into one string based on hashtags
    uncounted_hashtags = y.split(" ")
    # puts uncounted_hashtags
    # p uncounted_hashtags
    return uncounted_hashtags
  end

  def count_hashtags(uncounted_hashtags)  #method to count words
    x= uncounted_hashtags
    # p hashtags
    freq = Hash.new(0)
    x.each { |tag| freq[tag.downcase] += 1 }
    return freq  #returns hash with freq
  end

  def get_top_tags(sorted_tags)
    top_tags = []
    top_tags << sorted_tags[0...9]
    p "The top 10 Hashtags are #{top_tags}"
    return top_tags  #returns an array of top ten Tweet
  end

  def top_tweet_hashtags #search for top hashtags in tweets
    get_top_tags(
              sort_words(
              count_hashtags(
              flatten_tags(
              gather_tweet_hashtags))))
  end
################################### end hashtag methods##################################

############################ TOP Keyword in RSS Begin##################################
  def gather_rss_headlines #creates array of rss headlines
    i = 0
    text_to_search = []
    things = @news_rsses
    while i < things.length
      text_to_search << things[i].headline
      i += 1
    end
    return text_to_search
  end

  def top_rss_keywords #search for top words in RSS headlines
    get_top_words(
    remove_blacklisted_from_text(
              sort_words(
              count_words(
              flatten_text(
              gather_rss_headlines)))))
  end
############################### Top Keyword in RSS end##################################

############################### Top links in RSS Begin##################################
  def gather_rss_links #creates array of rss links
    i = 0
    urls_to_flatten = []
    things = @news_rsses
    while i < things.length
      urls_to_flatten << things[i].url
      i += 1
    end
    return urls_to_flatten
  end

  def flatten_rs_urls(urls_to_flatten) #puts rss feed urls into a string
    y = urls_to_flatten
    y = y.join(", ")
  end

  def count_rs_urls(uncounted_urls) #counts flattened urls and builds a hash
    urls = uncounted_urls.split(',')
    freq = Hash.new(0)
    urls.each { |url| freq[url.downcase] += 1 }
    return freq  #returns hash with freq
  end

  def get_top_rss_links #search for top links in RSS feed
    get_top_words(
              sort_words(
              count_rs_urls(
              flatten_rs_urls(
              gather_rss_links))))
  end
############################### Top links in RSS end ##################################

############################### Top links in Twitter Begin ##################################
  def gather_twitter_links #creates array of links from captured tweets
    i = 0
    urls_to_count = []
      @soc_meds.each do |x|
       txt = x[:urls].to_s
       re1='.*?'	# Non-greedy match on filler
       re2='((?:http|https)(?::\\/{2}[\\w]+)(?:[\\/|\\.]?)(?:[^\\s"]*))'	# HTTP URL 1
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

  def count_tw_links(urls_to_count)  #method to count words
    links = urls_to_count
    p "LINKS #{links}"
    freq = Hash.new(0)
    links.each { |word| freq[word.downcase] += 1 }
    p "FREQ #{freq}"
    return freq  #returns hash with freq
  end

  def sort_tw_links(freq)     #creates has of indv words with wordcount
    sorted = freq.sort_by {|k,v| v}.reverse # builds sorted array with highest first
    p "SORTED #{sorted}"
    return sorted
  end

  def top_tw_links(sorted_links) #returns an array of top ten Twitter links
    # p "BEFORE sorted links #{sorted_links}"
    top_links = []
    top_links << sorted_links[0...9]
    p "The top 10 Twitter links are #{top_links}"
    return top_links  #returns an array of top ten Twitter links
  end

  def get_top_tw_links #search for links in twitter feed
    top_tw_links(
      sort_tw_links(
      count_tw_links(
      gather_twitter_links)))
  end
############################### Top links in Twitter End
private

  def user_params
    params.require(:user).permit(:u_name, :email, :password, :password_confirmation, :google_auth_token)
  end
end
