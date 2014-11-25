require "rss_reader"
class Feed < ActiveRecord::Base
  include RssReader
  attr_accessible :feed_url
  attr_protected :title, :url, :description
  attr_accessor :entries
  
  validates :feed_url, presence: true, uniqueness: true
  
  before_validation do
    self.title, self.url, self.description = fetch_feed(self.feed_url)
    errors.add(:base, "Invalid feed url!") unless self.title
  end
end