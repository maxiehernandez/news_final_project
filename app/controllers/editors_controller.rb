class EditorsController < ApplicationController
  def new
    @editor = Editor.new
  end

  def create
    @editor = Editor.new
  end

  def dashboard
    @topic = Topic.new
    @topics = Topic.all
    @story = Story.new
    @stories = Story.all
  end



  private
    def editor_params
      params.require.(:editor).permit(:email)
    end
end
