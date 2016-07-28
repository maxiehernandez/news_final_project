require 'rss'

class RSSUtilities
  def initilize
    @cnn_all = RSS::Parser.parse('http://rss.cnn.com/rss/cnn_topstories.rss', false)
    @dem_now = RSS::Parser.parse('http://democracynow.org/democracynow.rss', false)
    @blk_agenda = RSS::Parser.parse('http://blackagendareport.com/rss.xml', false)
  end

  def build_rss_stories
    @cnn.items.each do |item|
      Story.create(body:"<li>#{item.title}</li><li>#{item.link}</li><li>#{item.pubdate}</li>")
    end

    @dem_now.items.each do |item|
      Story.create(body:"<li>#{item.title}</li><li>#{item.link}</li><li>#{item.pubdate}</li>")
    end

    @blk_agenda.items.each do |item|
      Story.create(body:"<li>#{item.title}</li><li>#{item.link}</li><li>#{item.pubdate}</li>")
    end
  end

end