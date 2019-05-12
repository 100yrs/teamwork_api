# TeamworkApi

[![Code Climate](https://codeclimate.com/github/100yrs/teamwork_api.png)][codeclimate]

[codeclimate]: https://codeclimate.com/github/100yrs/teamwork_api

The Teamwork API gem allows you to consume the Teamwork API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'teamwork_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install teamwork_api

## Usage

Over time this project intends to have a full Teamwork API. At the moment there are only a
few endpoints available:

```ruby
client = TeamworkApi::Client.new('https://yoursite.teamwork.com')
client.api_key = 'YOUR_API_KEY'

# Topic endpoints
client.latest_topics                            #=> Gets a list of the latest topics
client.hot_topics                               #=> Gets a list of hot topics
client.new_topics                               #=> Gets a list of new topics
client.topics_by("sam")                         #=> Gets a list of topics created by user "sam"
client.topic(57)                                #=> Gets the topic with id 57

# Search endpoint
client.search("sandbox")                        #=> Gets a list of topics that match "sandbox"

# Categories endpoint
client.categories                               #=> Gets a list of categories
client.category_latest_topics(category_slug: "lounge")  #=> Gets a list of latest topics in a category
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/teamwork_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TeamworkApi project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/100yrs/teamwork_api/blob/master/CODE_OF_CONDUCT.md).