class Subscription < ActiveRecord::Base
  attr_accessible :title, :user_id, :feed_id

  attr_accessor :xmlUrl

  def xmlUrl=(value)
  	@xmlUrl = value
  end
  
  #has_many :tags
  belongs_to :user
  has_one :feed

  validates :xmlUrl, presence: true
end
