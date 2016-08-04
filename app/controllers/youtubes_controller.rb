class YoutubesController < ApplicationController
  def create
    Youtube.find_or_create_by!(embed: params[:embed])
  end
end
