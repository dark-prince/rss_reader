module RssReader
	# Fetch all latest posts from a single feed.
	def fetch_feed(url)
		feed = Feedzirra::Feed.fetch_and_parse(url)
    
		if [Feedzirra::Parser::AtomFeedBurner, Feedzirra::Parser::RSS].include?(feed.class)
			[feed.title, feed.url, feed.description]
		else
			[nil, nil, nil]
		end    	
	end	
  
  # Fetch all latest post from multiple feeds.
  # And by default it will sort descending order by published.
  # If want to make it ascending order then have to pass 'asc' as parameter
	def fetch_feeds(feed_urls, sort = 'desc')
		feeds = Feedzirra::Feed.fetch_and_parse(feed_urls)
    return nil unless [Feedzirra::Parser::AtomFeedBurner, Feedzirra::Parser::RSS].include?(feeds.values.first.class)
    entries = feeds.values.collect { |feed| feed.entries }.reduce(:+)
    case sort
		when 'asc'
      entries.sort {|e1, e2| e1.published <=> e2.published }
		else
      entries.sort {|e1, e2| e2.published <=> e1.published }	
		end if entries
	end
end