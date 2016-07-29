class EditorsController < ApplicationController
  before_action :authorize
  before_action :require_admin

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
  end



  private
    def editor_params
      params.require.(:editor).permit(:email)
    end
end
