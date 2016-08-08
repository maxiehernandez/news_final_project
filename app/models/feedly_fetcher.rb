class FeedlyFetcher
  attr_reader :options

  def self.fetch(options={})
    new(options).create_stories
  end

  def initialize(options={})
    @options = options
  end

  def client
    # @client ||= Feedlr::Client.new(oauth_access_token:ENV['FEEDLY_KEY'])
    @client ||= Feedlr::Client.new(oauth_access_token:'A3zLWq0I7mm2q4E6iocX-lCJcpjI2pbFNA1Hi9phVkZlzMUjtk2GAyMBOFLl13DnvGWJ87FgJT_aaje1jJ1nebJl4z8vbof0JLmLWCZswIPifbtXMCSJ5x7s8En_YD6nyM98p9AWEMIs3C-d3-VtbcgsQvQn6QjljazJ3FJeazzn9P1wJEHIB3NpkzlhJlb89bmKnYgIXLmKAq6AKsGOiCq1qGvx7Vg')
  end

  def feeds
    @feeds ||= client.user_subscriptions
  end

  def save_stories(streams)
    stories = client.stream_entries_contents(streams, count: options[:count] || 5).to_h
    stories["items"].each do |story|
      News_rss.create(
      source_id: streams,
      source_name: story.origin.title,
      # pub_date: story.published,  #try Time.at(story.published)
      story_id: story.id,
      headline: story.title,
      url: story.originId,
      # summary: story.summary.content,
      keywords: story.keywords)
    end
  end

  def create_stories
    feeds.each do |feed_info|
      save_stories(feed_info.to_h['id'])
    end
  end
end
