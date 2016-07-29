class TopicsController < ApplicationController

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.create
    respond_to do |format|
      if @topic.save
        format.html {
          if request.xhr?
            render @topic
          else
            redirect_to @topic, notice: 'Topic was successfully created.', turbolinks: true, append: 'topics'
          end
        }
      end
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
    params.require.(:topic).permit(:name)
  end

end
