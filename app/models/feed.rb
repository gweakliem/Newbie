class Feed < ActiveRecord::Base
  attr_accessible :description, :etag, :htmlUrl, :lastRetrieve, :title, :xmlUrl
  validates_presence_of :title, :htmlUrl

  before_save { self.xmlUrl = xmlUrl.downcase }
end
