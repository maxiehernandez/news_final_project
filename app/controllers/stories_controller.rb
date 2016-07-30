require 'twitterutilities'
require 'rssutilities'

class StoriesController < ApplicationController
  def new
    @story = @topic.stories.create(stories_params)
  end

  def create
    @topic =
    @story = @topic.stories.create(stories_params)
    @story.topic_id = @topic.id

  end

  private

  def story_params
    params.require(:story).permit(:body, :topic_id)
  end


end
