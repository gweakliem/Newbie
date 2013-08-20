require 'clockwork'
require './config/boot'
require './config/environment'
require './lib/feed_fetcher_job'

module Clockwork
	configure do |config|
  		config[:sleep_timeout] = 5
  		config[:logger] = Rails.logger
  		config[:tz] = 'MST'
  		config[:max_threads] = 5
	end
	every(1.minutes, 'feed_fetcher.fetch') do
		Rails.logger.info "Queueing feed fetcher job"
		Delayed::Job.enqueue FeedFetcherJob.new 
	end
end