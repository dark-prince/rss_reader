require "spec_helper"

feature 'RSS Reader page' do
  scenario 'viewing the page' do
    visit root_path
  
    expect(page).to have_content('Listing feeds')
  end

  scenario 'viewing a list of feeds' do
    feeds = create_feeds
    visit root_path

    feeds[0..4].each do |feed|
      page.should have_content(feed.title)
    end
  end

  #  scenario 'with blank password' do
  #    sign_up_with 'valid@example.com', ''
  #
  #    expect(page).to have_content('Sign in')
  #  end
  #
  #  def sign_up_with(email, password)
  #    visit sign_up_path
  #    fill_in 'Email', with: email
  #    fill_in 'Password', with: password
  #    click_button 'Sign up'
  #  end
end

def feed_urls
  ["http://feeds.abcnews.com/abcnews/thelawheadlines", "http://feeds.abcnews.com/abcnews/entertainmentheadlines", "http://feeds.abcnews.com/abcnews/gmaheadlines", "http://feeds.abcnews.com/abcnews/healthheadlines", "http://feeds.abcnews.com/abcnews/internationalheadlines", "http://feeds.abcnews.com/abcnews/blotterheadlines", "http://feeds.abcnews.com/abcnews/moneyheadlines", "http://feeds.abcnews.com/abcnews/nightlineheadlines", "http://feeds.abcnews.com/abcnews/politicsheadlines", "http://feeds.abcnews.com/abcnews/primetimeheadlines", "http://feeds.abcnews.com/abcnews/sportsheadlines", "http://feeds.abcnews.com/abcnews/technologyheadlines", "http://feeds.abcnews.com/abcnews/thisweekheadlines", "http://feeds.abcnews.com/abcnews/topstories", "http://feeds.abcnews.com/abcnews/travelheadlines", "http://feeds.abcnews.com/abcnews/usheadlines", "http://feeds.abcnews.com/abcnews/worldnewsheadlines", "http://www.rss-specifications.com/blog-feed.xml", "http://www.feedforall.com/blog-feed.xml"]
end

def create_feeds
  feed_urls.collect { |feed_url| Feed.create(feed_url: feed_url) }
end