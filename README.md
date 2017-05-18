[![CircleCI](https://circleci.com/gh/mariodarco/itunes-api/tree/master.svg?style=shield)](https://circleci.com/gh/mariodarco/itunes-api/tree/master)


# ItunesApi

A simple interface for the Itunes Api.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'itunes_api'
```

And then execute:

```ruby
$ bundle
```

Or install it yourself as:

```ruby
$ gem install itunes_api
```

## Usage

To return all the AMG ids associated with a search term.
```ruby
ItunesApi.artist_ids('Pink Floyd')
```

To return structured information abut artists and albums associated with a search term.
```ruby
ItunesApi.artist_ids('Pink Floyd')
```

## Development

Ruby version:
```
2.3.3
```

Fork the project, clone the repository and bundle:
```
>> git clone https://github.com/{your_account}/itunes-api.git
>> cd itunes-api
```

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mariodarco/itunes-api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
