require 'twitterutilities'
require 'rssutilities'
class UsersController < ApplicationController

  # before_action :require_admin, only: :dashboard
  before_action :get_feeds, only: :dashboard

  def new
  end

  def home
  end

  def get_feeds
    # TwitterUtilities.client
    # TwitterUtilities.save_story
    # TwitterUtilities.build_story
    # RSSUtilities.build_rss_stories
    RSSUtilities.save_rss_stories
  end

  def dashboards
    @topic = Topic.new
    @topics = Topic.all
    @story = Story.new
    @stories = Story.all
    @soc_meds = Soc_med.all
    @soc_med = Soc_med.last
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
