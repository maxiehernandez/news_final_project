class TopicsController < ApplicationController

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.create(topic_params)
  end

  def index
    @topics = Topic.all
  end

  def show
  end


private
  def topic_params
    params.require(:topic).permit(:name)
  end

end
