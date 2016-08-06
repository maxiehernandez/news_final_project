require 'twitterutilities'
require 'rssutilities'

class StoriesController < ApplicationController
  def new
    @story = @topic.stories.create(story_params)
  end

  def create
    if params[:story_type] == "TW"  #makes Twitter Story
      @story = Story.create(
        body: "<a href='https://twitter.com/#{params[:tweeters_id]}/status/#{params[:t_id]}'></a>",
        topic_id: params[:topic_id],
        story_type: "TW")
      elsif params[:story_type] == "RS"  #makes RSS story
        @story = Story.create(body: "<div class='media'><div class='media-body'><h2 class='media-heading'><a href='#{params[:url]}'>#{params[:headline]}</a></h2><p>#{params[:sousource_name]} <%=Time.at#{params[:pub_date]}%></p></div><div class='media-left'><a href='#{params[:url]}'><img class='media-object' src='#{params[:pic_url]}'></a></div></div>", topic_id: params[:topic_id], story_type: "RS")
      elsif :story_type == "TW10"  #makes top ten tweet story type
          @story = Story.create(
            body: "<a href='https://twitter.com/#{params[:tweeters_id]}/status/#{params[:t_id]}'></a>",
            topic_id: 0,
            story_type: "TW10")
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
