class SocMedsController < ApplicationController
  def new
    @soc_med = Soc_med.new
  end

  def create
    @soc_med = Soc_med.create(soc_med_params)
  end


private
  def soc_med_params
    params.require(:soc_med).permit(:tweeters_id, :tweet_id, :favorites, :retweets, :text, :hashtags, :mentions, :urls :followers, :screen_name, :friends, :rank)
  end

end
