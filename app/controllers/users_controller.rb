require 'twitterutilities'
require 'rssutilities'

class UsersController < ApplicationController
  # before_action :require_admin, only: :dashboard
  before_action :get_feeds, only: [:dashboard]

  def new
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
    TwitterUtilities.save_story  # saves Tweets from Twitter API into Soc_med
    # RSSUtilities.save_rss_stories #saves RSS stories from feeds into News_rss
    # lose_the_lames # deletes tweets with less than 10 retweets
    # get_top_twitter_links
  end

  def dashboard
    @topics = Topic.order("position")
    @rss_feed = RssFeed.new
  end

  def select_rss
    News_rss.last(50).each do |news|
      Story.create!(body: "<div class='media'><div class='media-body'><h2 class='media-heading'><a href='#{news[:url]}'>#{news[:headline]}</a></h2><p>VIA *NEED SOURCE* #{news[:pub_date]}</p></div><div class='media-left'><a href='#{news[:url]}'><img class='media-object' src='https://hd.unsplash.com/photo-1453227588063-bb302b62f50b'></a></div></div>", topic_id: 13, story_type: "RS")
    end
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



# Editor Search function
  def editor_search
    @results = Soc_med.where text: params[:term]
    redirect_to '/dashboard'
  end


  # #Return 25 most popular tweets 'sort_by_retweet'
  # def lose_the_lames
  #   @soc_meds.map  do |x|
  #     x.delete if (x.retweets.nil? || x.retweets < 10)
  #   end
  # end


  #Begin Keyword Frequency Methods
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

  def gather_twitter_links #creates array of links from captured tweets
    i = 0
    urls_to_flatten = []
    things = @soc_meds
    while i < things.length
      urls_to_flatten << things[i].urls
      i += 1
    end
    p urls_to_flatten
    return urls_to_flatten
  end

  def flatten_urls(urls_to_flatten) #puts rss feed urls into a string
    y = urls_to_flatten
    y = y.join(", ")
  end

  def count_urls(uncounted_urls) #counts flattened urls and builds a hash
    urls = uncounted_urls.split(',')
    freq = Hash.new(0)
    urls.each { |url| freq[url.downcase] += 1 }
    return freq  #returns hash with freq
  end


  def flatten(text_to_search)
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
    top_ten = []
    top_ten << cleaned_and_sorted[0...20]
    p top_ten
    # return top_ten
  end


  def top_tweet_keywords # search for top keywords in tweets
    get_top_words(
    remove_blacklisted_from_text(
              sort_words(
              count_words(
              flatten(
              gather_tweet_array)))))
  end

  def top_rss_keywords #search for to words in RSS headlines
    get_top_words(
    remove_blacklisted_from_text(
              sort_words(
              count_words(
              flatten(
              gather_rss_headlines)))))
  end

#End Keyword Frequency Methods

def get_top_rss_links #search for top links in RSS feed
  get_top_words(
            sort_words(
            count_urls(
            flatten_urls(
            gather_rss_links))))
end

def get_top_twitter_links #search for links in twitter feed
  get_top_words(
            sort_words(
            count_urls(
            flatten_urls(
            gather_twitter_links))))
end


  def update
    @user = User.find(params[:id])
    @user.update(user_params)
  end

  def show
  end

private

  def user_params
    params.require(:user).permit(:u_name, :email, :password, :password_confirmation, :google_auth_token)
  end
end
