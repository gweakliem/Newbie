class FeedFetcherJob
	def perform
		#raw = RestClient.get('http://www.eighty-twenty.net/weblog/atom', :accept => :xml)
		raw = RestClient.get('http://localhost:3000/atom.xml', :accept => :xml)

		# parse the feed
    #Feed.create! :value => data.first['l']		
    # if feed doesn't exist, create it
    # Set feed metadata to what was parsed
    # add individial posts to feed.
    # check for posts to be archived
	end
end