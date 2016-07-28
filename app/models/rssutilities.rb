require 'rss'

class RSSUtilities
  def initilize
    @cnn_all = RSS::Parser.parse('http://rss.cnn.com/rss/cnn_topstories.rss', false)
    @dem_now = RSS::Parser.parse('http://democracynow.org/democracynow.rss', false)
    @blk_agenda = RSS::Parser.parse('http://blackagendareport.com/rss.xml', false)
  end


  @cnn = RSS::Parser.parse('http://rss.cnn.com/rss/cnn_topstories.rss', false)
  puts cnn.items

  cnn.items.each do |item|
    puts "#{item.pubDate}"
    puts "#{item.title}"
    puts "#{item.link}"
  end


  @dem_now = RSS::Parser.parse('http://democracynow.org/democracynow.rss', false)
  puts dem_now.items

  dem_now.items.each do |item|
    puts "#{item.pubDate}"
    puts "#{item.title}"
    puts "#{item.link}"
  end


  @blk_agenda = RSS::Parser.parse('http://blackagendareport.com/rss.xml', false)
  puts blk_agenda.items

  blk_agenda.items.each do |item|
    puts "#{item.pubDate}"
    puts "#{item.title}"
    puts "#{item.link}"
  end
end
