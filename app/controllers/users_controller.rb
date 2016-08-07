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
    # TwitterUtilities.save_story  # saves Tweets from Twitter API into Soc_med
    Soc_med.build_top_tweet_stories #builds stories from top 10 most retweeted tweets
    # Soc_med.top_retweets
    # RSSUtilities.save_rss_stories #saves RSS stories from feeds into News_rss
    # top_tweet_hashtags  #returns top ten hashtags to console
    # get_top_tw_links  #gets top twitter links w count
    # save_rss_images
    # FeedlyFetcher.fetch
  end

  def dashboard
    @topics = Topic.order("position")
    @rss_feed = RssFeed.new
  end

  HTTP_ERRORS = [
  HTTParty::UnsupportedURIScheme,
  URI::InvalidURIError,
  Errno::ECONNREFUSED
  ]

  def save_rss_images
    @news_rsses. each do |rss_story|
      if rss_story.pic_url.nil?
        link = rss_story.url
        begin
          body = HTTParty.get(link).response.body
        rescue *HTTP_ERRORS => error
          # @news_rsses.next
        end
          dom = Nokogiri::HTML(body)
          if dom.css("meta[property='og:image']").present?
            rss_story.pic_url = dom.css("meta[property='og:image']").attribute('content').value
            rss_story.pic_url
            rss_story.save
          elsif dom.css("meta[id='ogimage']").present?
            rss_story.pic_url = dom.css("meta[id='ogimage']").attribute('content').value
            rss_story.pic_url
            rss_story.save
          else
            # p "no pic for #{rss_story.url}."
          end
        end
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
