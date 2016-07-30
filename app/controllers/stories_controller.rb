require 'twitterutilities'
require 'rssutilities'

class StoriesController < ApplicationController
  def new
    @story = Story.new
  end

  def create
    @story = Story.create(story_params)
  end

  private

  def story_params
    params.require(:story).permit(:body, :topic_id)
  end


end
