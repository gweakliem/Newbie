class FeedFetcherJob
	def perform
		#raw = RestClient.get('http://www.eighty-twenty.net/weblog/atom', :accept => :xml)
		raw = RestClient.get('http://localhost:3000/atom.xml', :accept => :xml)
    Feed.create! :value => data.first['l']		
	end
end