require 'feedzirra'

class FeedFetcherJob
	def perform
		Delayed::Worker.logger.debug "FeedFetcherJob.perform"
		Feed.all.each do |feed|
			Delayed::Worker.logger.debug "Fetching #{feed}"
			feed = Feedzirra::Feed.fetch_and_parse("http://localhost:3000/atom.xml")
			updated_feed = Feedzirra::Feed.update(feed)

			#updated_feed.updated?     # returns true if any of the feed attributes have been modified. will return false if only new entries
			#updated_feed.new_entries  # a collection of the entry objects that are newer than the latest in the feed before update

			# parse the feed
		    #Feed.create! :value => data.first['l']		
		    # if feed doesn't exist, create it
		    # Set feed metadata to what was parsed
		    # add individial posts to feed.
		    # check for posts to be archived
    	end
	end
end