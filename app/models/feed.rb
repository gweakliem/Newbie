class Feed < ActiveRecord::Base
  attr_accessible :description, :etag, :htmlUrl, :lastRetrieve, :title, :xmlUrl
end
