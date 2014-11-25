require "rss_reader"
class FeedsController < ApplicationController
  include RssReader

  # GET /feeds
  # GET /feeds.json
  def index
    @feeds = Feed.order(:title).page(params[:page]).per(5)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @feeds }
    end
  end
  
  # GET /feeds/readers
  # GET /feeds/readers.json
  def readers
    @posts = fetch_feeds(Feed.all.collect { |f| f.feed_url })
    respond_to do |format|
      format.html # readers.html.erb
      format.json { render json: @posts }
    end
  end
  
  # GET /feeds/new
  # GET /feeds/new.json
  def new
    @feed = Feed.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @feed }
    end
  end
  
  # POST /feeds
  # POST /feeds.json
  def create
    @feed = Feed.new(feed_params)
    if @feed.save
      respond_to do |format|
        format.html { redirect_to @feed, notice: 'Successfully created.' }
        format.json { render json: @feed, status: :created, location: @feed }
      end
    else
      respond_to do |format|
        format.html { render action: "new" }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # GET /feeds/1
  # GET /feeds/1.json
  def show
    @feed = Feed.find(params[:id])
    @feed.entries = Feedzirra::Feed.fetch_and_parse(@feed.feed_url).entries rescue nil

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @feed }
    end
  end
  
  # GET /feeds/1/edit
  # GET /feeds/1/edit.json
  def edit
    @feed = Feed.find(params[:id])
  end
  
  # PUT  /feeds/1
  # PUT  /feeds/1.json
  def update
    @feed = Feed.find(params[:id])

    respond_to do |format|
      if @feed.update_attributes(feed_params)
        format.html { redirect_to @feed, notice: 'Successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /feeds/1
  # DELETE /feeds/1.json
  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy

    respond_to do |format|
      format.html { redirect_to feeds_path }
      format.json { head :no_content }
    end
  end
  
  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def feed_params
    params.require(:feed).permit(:feed_url)
  end
end