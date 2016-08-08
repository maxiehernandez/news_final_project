class RssFeed < ApplicationRecord
  validates :url, uniqueness: true

  HTTP_ERRORS = [
  HTTParty::UnsupportedURIScheme,
  URI::InvalidURIError,
  Errno::ECONNREFUSED
  ]

  def self.save_rss_images
    News_rss.all. each do |rss_story|
      if rss_story.pic_url.nil?
        link = rss_story.url
        begin
          body = HTTParty.get(link).response.body
        rescue *HTTP_ERRORS => error
        end

        dom = Nokogiri::HTML(body)

        if dom.css("meta[property='og:image']").present?
          rss_story.pic_url = dom.css("meta[property='og:image']").attribute('content').value
          rss_story.pic_url
          rss_story.save
        elsif dom.css("meta[id='ogimage']").present?
          rss_story.pic_url = dom.css("meta[id='ogimage']").attribute('content').value
          rss_story.pic_url
          rss_story.save
        else
          # p "no pic for #{rss_story.url}."
        end
      end
    end
  end

############################ TOP Keyword in RSS Begin##################################
  def self.gather_rss_headlines #creates array of rss headlines
    i = 0
    text_to_search = []
    things = News_rss.all
    while i < things.length
      text_to_search << things[i].headline
      i += 1
    end
    return text_to_search
  end

  def self.flatten_text(text_to_search)
    y = text_to_search
    y = y.join(", ").gsub!(/[[:punct:]]/, '') # flattens array into one string based on commas and removes punctuation from inside array
    return y
  end
  def self.sort_words(stuff)     #creates has of indv words with wordcount
    sorted = stuff.sort_by {|k,v| v}.reverse # builds sorted array with highest first
    return sorted
  end

  def self.add_blacklist_word(word)
   blacklist = %w[rt is about the]  # creates blacklisted words
   blacklist << word
  end

  def self.remove_blacklisted_from_text(sorted)
    blacklist = %w[headlines new, how pallette color your team watch first their out can state trump away it's but if up or do his been if it a no being had as after from like are they our powertv her only day have when need dont don't via him get most really will us my there by she at has me what so etc of a i in you for and with to this on to he amp more we just im who people http https that not be an was rt is about the]  # creates blacklisted words
    blacklist.each do |blacklisted|  #deletes blacklisted words
      sorted.delete_if {|key, value| key == blacklisted}
    end
    return sorted
  end

  def self.count_words(uncounted_words)  #method to count words
    words = uncounted_words.split(' ')
    freq = Hash.new(0)
    words.each { |word| freq[word.downcase] += 1 }
    return freq  #returns hash with freq
  end

  def self.get_top_words(cleaned_and_sorted)
    cleaned_and_sorted[0...9]
    # p "The Top 20 Keywords in tweets are #{cleaned_and_sorted}"
    return cleaned_and_sorted
  end

  def self.top_rss_keywords #search for top words in RSS headlines
    get_top_words(
    remove_blacklisted_from_text(
              sort_words(
              count_words(
              flatten_text(
              gather_rss_headlines)))))
  end
############################### Top Keyword in RSS end##################################
############################### Top links in RSS Begin##################################
  def self.gather_rss_links #creates array of rss links
    i = 0
    urls_to_flatten = []
    things = News_rss.all
    while i < things.length
      urls_to_flatten << things[i].url
      i += 1
    end
    return urls_to_flatten
  end

  def self.flatten_rs_urls(urls_to_flatten) #puts rss feed urls into a string
    y = urls_to_flatten
    y = y.join(", ")
  end
  def self.count_rss_urls(uncounted_urls) #counts flattened urls and builds a hash
    urls = uncounted_urls.split(',')
    freq = Hash.new(0)
    urls.each { |url| freq[url.downcase] += 1 }
    return freq  #returns hash with freq
  end

  def self.get_top_rss_links #search for top links in RSS feed
    get_top_words(
              sort_words(
              count_rs_urls(
              flatten_rs_urls(
              gather_rss_links))))
  end
end
