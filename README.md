# ItunesApi

A simple interface for the Itunes Api.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'itunes_api'
```

And then execute:

```ruby
bundle
```

Or install it yourself as:

```ruby
gem install itunes_api
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

To get all artists returning from a search term

```ruby
ItunesApi::Music.find_by_name('Led Zeppelin')
```

To return a specific artist, based on the artist's Apple id

```ruby
ItunesApi::Music.find_by_apple_id(265766061)
```

Note that each request that returns artists does not automatically return albums.
They are lazily fetched when calling artist.albums.

To return only the albums for a specific artist, based on the artist's Apple id

```ruby
ItunesApi::Music.find_albums_by_apple_id(265766061)
```

To return a specific album, based on the album's collection id

```ruby
ItunesApi::Music.find_by_collection_id(286930912)
```

Note that each request that returns albums does not automatically return songs.
They are lazily fetched when calling album.tracklist.

To return only the songs for a specific album, based on the album's collection id

```ruby
ItunesApi::Music.find_songs_by_collection_id(286930912)
```

To return a specific track, based on its track id

```ruby
ItunesApi::Music.find_by_track_id(286931522)
```

---

An argument holding the country code can be used to look into different stores than the default one

```ruby
ItunesApi::Music.find_by_name('Led Zeppelin', :fr)
ItunesApi::Music.find_by_apple_id(265766061, :us)
ItunesApi::Music.find_albums_by_apple_id(265766061, :es)
```

## Development

Ruby version:

```text
>= 3.1
```

Fork the project, clone the repository and bundle:

```bash
>> git clone https://github.com/{your_account}/itunes-api.git
>> cd itunes-api
```

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/mariodarco/itunes-api](https://github.com/mariodarco/itunes-api). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
