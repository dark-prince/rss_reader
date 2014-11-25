require "spec_helper"

describe Feed do
  it { should allow_mass_assignment_of(:feed_url) }

  it { should allow_mass_assignment_of(:entries) }

  it { should_not allow_mass_assignment_of(:title) }

  it { should_not allow_mass_assignment_of(:url) }

  it { should_not allow_mass_assignment_of(:description) }

  it { should have_db_column(:feed_url) }

  it { should have_db_column(:title) }

  it { should have_db_column(:url) }

  it { should have_db_column(:description) }

  it { should_not have_db_column(:entries) }

  it "fails validation with no feed_url" do
    Feed.new.should have(1).error_on(:feed_url)
  end

  it "fails validation with duplicate feed_url" do
    Feed.create(feed_url: 'http://feeds.feedburner.com/PaulDixExplainsNothing')
    Feed.new(feed_url: 'http://feeds.feedburner.com/PaulDixExplainsNothing').should have(1).error_on(:feed_url)
  end

  it "fails validation with no title" do
    Feed.new(feed_url: 'http://rspec.info').should have(1).errors_on(:base)
  end

  it "passes validation with a feed_url" do
    Feed.new(feed_url: 'http://feeds.feedburner.com/PaulDixExplainsNothing').should have(0).errors_on(:feed_url)
  end
end