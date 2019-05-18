# TeamworkApi

[![Build](https://travis-ci.org/100yrs/teamwork_api.svg?branch=master)](https://travis-ci.org/100yrs/teamwork_api)
[![Maintainability](https://api.codeclimate.com/v1/badges/ad05d9af4c9a0d2cc4dd/maintainability)](https://codeclimate.com/github/100yrs/teamwork_api/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/ad05d9af4c9a0d2cc4dd/test_coverage)](https://codeclimate.com/github/100yrs/teamwork_api/test_coverage)

The Teamwork API gem allows you to consume the [Teamwork API](https://developer.teamwork.com/)

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

# Project endpoints
client.projects                                 #=> Gets all projects
client.project(57)                              #=> Gets the project with id 57
client.delete_project(57)                       #=> Deletes the project with id 57
client.create_project(                          #=> Creates a new project
  name: 'My Project'
)
client.update_project(                          #=> Updates project with id 57
  57,
  name: 'Renamed Project'
)

# Company endpoints
client.companies                                #=> Gets all companies
client.company(51)                              #=> Gets the company with id 51
client.company_by_name('ABC Corp')              #=> Gets the company with name "ABC Corp"

# People endpoints
client.people                                   #=> Gets all people
client.person(49)                               #=> Gets the person with id 49
client.add_person_to_project(57, 49)            #=> Adds the person with id 49 to the project with id 57
client.set_permissions(                         #=> Sets the person with id 49 as an administrator of the project with id 57
  57,
  49,
  'project-administrator': true
)

# Project Owner endpoints
client.project_owner(57)                        #=> Gets the owner details for the project with id 57

# Task List endpoints
client.task_lists                               #=> Gets all task lists
client.task_list(45)                            #=> Gets the task list with id 45
client.delete_task_list(45)                     #=> Deletes the task list with id 45
client.create_task_list(                        #=> Creates a new task list for the project with id 57
  57,
  name: 'My list'
)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/100yrs/teamwork_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Acknowledgements

The structure and much of the helper code for this gem was borrowed from the [Discourse API](https://github.com/discourse/discourse_api) gem.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TeamworkApi project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/100yrs/teamwork_api/blob/master/CODE_OF_CONDUCT.md).
