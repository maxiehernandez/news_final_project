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
    # FeedlyFetcher.fetch
    # TwitterUtilities.save_story  # saves Tweets from Twitter API into Soc_med
    # RssFeed.save_rss_images
    # RSSUtilities.save_rss_stories #saves RSS stories from feeds into News_rss
  end

  def dashboard
    @topics = Topic.order("position")
    @rss_feed = RssFeed.new
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


private
  def user_params
    params.require(:user).permit(:u_name, :email, :password, :password_confirmation, :google_auth_token)
  end
end
