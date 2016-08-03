require 'twitterutilities'
require 'rssutilities'

class StoriesController < ApplicationController
  def new
    @story = @topic.stories.create(stories_params)
  end

  def create
    if params[:story_type] == "TW"
      @story = Story.create(
        body: "<a href='https://twitter.com/#{params[:tweeters_id]}/status/#{params[:t_id]}'>Tweet!!!</a>",
        topic_id: params[:topic_id],
        story_type: "TW")


      if @story.save!
        head :created
      else
        puts "ERROR!!!"
      end
    end
    # @topic =
    # @story = @topic.stories.create(stories_params)
    # @story.topic_id = @topic.id

  end

  private

  def story_params
    params.require(:story).permit(:body, :topic_id)
  end


end
