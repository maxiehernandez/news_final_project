require 'rails_helper'
require 'twitterutilities'
require 'rssutilities'

RSpec.feature "EditorAddStoryFlows", type: :feature do
  before(:each) do
    Topic.create(name:"Election 2016")
    Topic.create(name:"US News")
    Topic.create(name:"Immigration")
    Topic.create(name:"BlackLivesMatter")
    Topic.create(name:"Breaking News")
    Editor.create(email:"john@gmail.com")

    TwitterUtilities.build_story
    rss = RSSUtilities.new
    rss.build_rss_stories

    visit root_path
  end

  # Editor goes to dashboard to view tending topics, RSS, Twitter, and YouTube feeds.
    it "Shows a dashboard to view tending topics, RSS, Twitter, YouTube feeds, and trending topics" do
      expect(page).to have_content("RSS Stories")
      expect(page).to have_content("example0")
      expect(page).to have_content("Top Tweets")
      expect(page).to have_content("example1")
      expect(page).to have_content("Top Videos")
      expect(page).to have_content("example2")
      expect(page).to have_content("Trending Topics")
      expect(page).to have_content("US News")
    end

  # Editor fills out trending topic form
  it "should add trending topics" do
    fill_in 'Name', with:'Sports'
    click_button 'Create Topic'
    expect(page).to have_content('Sports')
  end

  # Confirmation diolog box for editor to confirm submition
  # Editor edits trending topic
  # Editor confirms submition
  # Editor declines submition
  # Editor deletes topic


# RSS
  # Editor selects story to add to topic
  # Editor selects story to add to homepage
  # Editor deletets story from topic
  # Editor deletes story from to homepage

# Twitter
  # Editor selects story to add to topic
  # Editor selects story to add to homepage
  # Editor deletets story from topic
  # Editor deletes story from to homepage

# YouTube
  # Editor selects story to add to topic
  # Editor selects story to add to homepage
  # Editor deletets story from topic
  # Editor deletes story from to homepage

end
