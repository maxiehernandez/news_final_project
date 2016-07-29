class TopicsController < ApplicationController

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def index
    @topics = Topic.all
  end

  def show
    if request.xhr?
      render '_topic', layout: false, locals: { topic: @topic }
    end
  end


private
  def topic_params
    params.require(:topic).permit(:name)
  end

end
