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
    @topics = Topic.all
  end

  def show
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

private
  def topic_params
    params.require(:topic).permit(:name)
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end
end
