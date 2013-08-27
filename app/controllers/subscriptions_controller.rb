class SubscriptionsController < ApplicationController
  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @subscriptions = Subscription.find_all_by_user_id(session[:user_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @subscriptions }
    end
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
    @subscription = Subscription.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subscription }
    end
  end

  # GET /subscriptions/new
  # GET /subscriptions/new.json
  def new
    @subscription = Subscription.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subscription }
    end
  end

  # GET /subscriptions/1/edit
  def edit
    @subscription = Subscription.find(params[:id])
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    logger.debug "Create subscription params #{@params} session #{@session}"
    existing_feed = Feed.find_by_xmlUrl(params[:subscription][:xmlUrl])
    if (existing_feed == nil)
      logger.debug "Feed not found"
      feed = Feedzirra::Feed.fetch_and_parse(params[:subscription][:xmlUrl])
      logger.debug "fetched feed #{feed}"
      #feed.last_modified  # => Sat Jan 31 17:58:16 -0500 2009 # it's a Time object
      existing_feed = Feed.new(xmlUrl: feed.xmlUrl,
        description: feed.title, etag: feed.etag, htmlUrl: feed.url, lastRetrieve: nil, title: feed.title)
      existing_feed.save
    end
    logger.debug "Adding subscription to feed #{existing_feed.id} for user #{@session}"
    title = params[:subscription][:title] || feed.title
    @subscription = Subscription.new(title: title)
    @subscription.user_id = session[:user_id]
    @subscription.feed_id = existing_feed.id

    respond_to do |format|
      if @subscription.save
        format.html { redirect_to @subscription, notice: 'Subscription was successfully created.' }
        format.json { render json: @subscription, status: :created, location: @subscription }
      else
        format.html { render action: "new" }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /subscriptions/1
  # PUT /subscriptions/1.json
  def update
    @subscription = Subscription.find(params[:id])

    respond_to do |format|
      if @subscription.update_attributes(params[:subscription])
        format.html { redirect_to @subscription, notice: 'Subscription was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy

    respond_to do |format|
      format.html { redirect_to subscriptions_url }
      format.json { head :no_content }
    end
  end
end
