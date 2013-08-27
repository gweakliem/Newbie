== Newbie, the Newsreader

Yet another Newsreader, Newbie is intended to provide basic River of News functionality 
for multiple users. 

Newbie allows a user to: 

1. subscribe to individual feeds or to import OPML

2. Apply tags to feeds for organizational purposes

3. Read news

In addition, Newbie will schedule feed fetches behind the scenes to keep the news stream 
fresh. 

== Basic Architecture

There are 3 main components to Newbie:

1. The main webapp 

2. A cron job, built with Clockwork, that fetches feeds on a regular interval.

3. A delayed_job server which schedules the feed fetch.

== Getting Started

1. Clone the project

2. Start Newbie using the following commands

$ bundle exec rails server &
$ bundle exec rake jobs:work & 
$ bundle exec clockwork app/clock.rb &