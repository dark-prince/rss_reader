require "spec_helper"

describe RssReader do
  before(:each) do
		@feed = Class.new do
			include RssReader
		end
	end
	
	describe "fetch_feed" do
    it "should return an array with nil elements" do
    	Feedzirra::Feed.should_receive(:fetch_and_parse).with('invalid_url').and_return(0)
      @feed.new.fetch_feed('invalid_url').should == [nil, nil, nil]
    end
    
    it "should return a non empty array" do
      feed = feed_create(Faker::Name.title, 'test_url', Faker::Lorem.word)
      Feedzirra::Feed.should_receive(:fetch_and_parse).with('valid_url').and_return(feed)
      @feed.new.fetch_feed('valid_url').should == [feed.title, feed.url, feed.description]
    end
  end
  
  describe "fetch_feeds" do
    it "should return an empty array" do
    	@feed.new.fetch_feeds(['invalid_url_1', 'invalid_url_2']).should == nil
    end
  end

  def feed_create(title, url, description)
  	feed = Feedzirra::Parser::RSS.new
  	feed.title = title
    feed.url = url
  	feed.description = description
  	feed
  end
end