class TopicsController < ApplicationController
before_action :set_topic, only: [:show, :edit, :update, :destroy]
  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      redirect_to '/dashboard'
    else
      render 'new'
    end

  end

  def index
    @topics = Topic.order("position")
  end

  def show
    @topic = Topic.friendly.find(params[:id])
  end

  def trending
    @topic = Topic.friendly.find('Trending')
  end

  def edit
  end

  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to '/dashboard', notice: 'Topic was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def sort
    params[:topic].each_with_index do |id, index|
      Topic.where(id: id).update(:position => index+1)
    end
  end

private
  def topic_params
    params.require(:topic).permit(:name)
  end

  def set_topic
    @topic = Topic.friendly.find(params[:id])
  end
end
