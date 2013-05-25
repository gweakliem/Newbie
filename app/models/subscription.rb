class Subscription < ActiveRecord::Base
  attr_accessible :title

  attr_accessor :xmlUrl

  def xmlUrl=(value)
  	@xmlUrl = value
  end
  
  #has_many :tags
  belongs_to :user
  has_one :feed
end
