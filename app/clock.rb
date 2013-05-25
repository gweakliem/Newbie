require 'config/boot'
require 'config/environment'

every(60.minutes, 'feed_fetcher.fetch') { Delayed::Job.enqueue FeedFetcherJob.new }
