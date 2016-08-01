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
    # TwitterUtilities.save_story
    # TwitterUtilities.build_story
    # RSSUtilities.save_rss_stories
    # select_rss
  end

  def dashboard
    @news_rss = News_rss.new
    @news_rsses = News_rss.all
    @topic = Topic.new
    @topics = Topic.all
    @story = Story.new
    @stories = Story.all
    @soc_meds = Soc_med.all
    @soc_med = Soc_med.new
    @topics = Topic.order("position")
  end

  def select_rss
    News_rss.last(10).each do |news|
      p news
      Story.create!(body: "<div class='media'><div class='media-body'><h2 class='media-heading'><a href='#{news[:url]}'  target='_blank'>#{news[:headline]}</a></h2><p>VIA *NEED SOURCE* #{news[:pub_date]}</p></div><div class='media-left'><a href='#{news[:url]}' target='_blank'><img class='media-object' src='https://hd.unsplash.com/photo-1453227588063-bb302b62f50b'></a></div></div>", topic_id: 21)
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
