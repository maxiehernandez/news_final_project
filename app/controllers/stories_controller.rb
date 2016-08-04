require 'twitterutilities'
require 'rssutilities'

class StoriesController < ApplicationController
  def new
    @story = @topic.stories.create(stories_params)
  end

  def create
    if params[:story_type] == "TW"
      @story = Story.create(
        body: "<a href='https://twitter.com/#{params[:tweeters_id]}/status/#{params[:t_id]}'></a>",
        topic_id: params[:topic_id],
        story_type: "TW")
      elsif params[:story_type] == "RS"
        @story = Story.create(body: "<div class='media'><div class='media-body'><h2 class='media-heading'><a href='#{params[:url]}'>#{params[:headline]}</a></h2><p>VIA *NEED SOURCE* #{params[:pub_date]}</p></div><div class='media-left'><a href='#{params[:url]}'><img class='media-object' src='https://hd.unsplash.com/photo-1453227588063-bb302b62f50b'></a></div></div>", topic_id: params[:topic_id], story_type: "RS")
      end

    if @story.save!
      head :created
    else
      puts "ERROR!!!"
    end
  end


  private

  def story_params
    params.require(:story).permit(:body, :topic_id)
  end

end
