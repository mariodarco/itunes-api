[![Gem Version](https://badge.fury.io/rb/itunes_api.svg)](https://badge.fury.io/rb/itunes_api) [![Dependency Status](https://gemnasium.com/badges/github.com/mariodarco/itunes-api.svg)](https://gemnasium.com/github.com/mariodarco/itunes-api) [![CircleCI](https://circleci.com/gh/mariodarco/itunes-api/tree/master.svg?style=shield)](https://circleci.com/gh/mariodarco/itunes-api/tree/master)


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

## Configuration

Add an initializer to your app to set the country for the Store:
```ruby
# config/initializers/itunes_api.rb
ItunesApi.configure do |config|
  config.country_code = ENV['COUNTRY_CODE'] || :gb
end
```

## Usage

To return all the Apple ids associated with a search term.
```ruby
ItunesApi.artist_ids('Pink Floyd')
```

To get all artists returning from a search term, and their albums.
```ruby
ItunesApi.artist_search('Led Zeppelin')
```

To return a specific artist with albums, based on the Apple id.
```ruby
ItunesApi.artist_lookup(265766061)
```

To return the tracklist for a specific albums, based on the Apple collection id.
```ruby
ItunesApi.album_lookup(286930912)
```

An argument holding the country code can be used to look into different stores than the default one.

```ruby
ItunesApi.artist_ids('Pink Floyd', :it)
ItunesApi.artist_search('Led Zeppelin', :fr)
ItunesApi.artist_lookup(265766061, :us)
ItunesApi.album_lookup(286930912, :gb)
```

## Development

Ruby version:
```
2.4.1
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
