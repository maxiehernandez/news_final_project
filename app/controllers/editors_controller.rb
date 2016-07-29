class EditorsController < ApplicationController
  def dashboard
    @topic = Topic.new
    @topics = Topic.all
    @story = Story.new
  end
end
