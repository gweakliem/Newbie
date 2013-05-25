class Post < ActiveRecord::Base
  attr_accessible :description, :feed_id, :link, :pubDate, :title
end
