require "spec_helper"

describe FeedsController do
  
  describe "GET #index" do
    it "should get index" do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end
  
  describe "GET #readers" do
    before(:each) do
      @feed = FactoryGirl.create(:feed)
    end

    it "should get readers" do
      get :readers
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end
  
  describe "GET #new" do
    it "should get new" do
      get :new
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end
  
  describe "POST #create" do
    it "should create a feed" do
      lambda do
        post :create, feed: { feed_url: "http://feeds.feedburner.com/PaulDixExplainsNothing" }
      end.should change(Feed, :count).by(1)
    end
  end
  
  describe "GET #show" do
    let(:feed) { FactoryGirl.create(:feed) }
    
    it "should show a feed" do
      get :show, id: feed
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end
  
  describe "GET #edit" do
    let(:feed) { FactoryGirl.create(:feed) }
    
    it "should edit a feed" do
      get :edit, id: feed
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end
  
  describe "PUT #update" do
    let(:feed) { FactoryGirl.create(:feed) }
    
    it "should update a feed" do
      put :update, id: feed, feed: { feed_url: "http://feeds.feedburner.com/trottercashion" }
      response.should redirect_to(feed)
    end
  end
  
  describe "DELETE #destroy" do
    let(:feed) { FactoryGirl.create(:feed) }
    
    it "should destroy a feed" do
      expect { delete :destroy, :id => feed }.to change(Feed, :count).by(0)
      response.should redirect_to(feeds_path)
    end
  end
end