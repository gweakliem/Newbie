class Subscription < ActiveRecord::Base
  attr_accessible :title, :user_id, :feed_id

  def xmlUrl=(value)
  	@xmlUrl = value
  end

  def xmlUrl
  	feed = Feed.find_by_id(self.feed_id)
    logger.debug "Found feed #{feed} for subscription #{@feed_id}"
  	@xmlUrl ||= (feed != nil) ? feed.xmlUrl : nil;
	end
  
  #has_many :tags
  belongs_to :user
  has_one :feed

end
