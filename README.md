# Loopiator
Ruby gem for Interacting with Loopia.se's XML RPC API.

## Installation
Add the loopiator to your Gemfile and run bundle update:
```ruby
gem 'loopiator'
bundle update
```

Generate an initializer for your app:

```ruby
rails generate loopiator username password
```

You'll find your API credentials in Loopia's control panel.

## Usage

Basic example:
```ruby
client          =   Loopiator::Client.new
available       =   client.domain_is_free('google.se')
```

## Notes
The full Loopia API hasn't been implemented. I've just implemented the things I need for now. If you need more functionality, either implement it yourself and send a pull request or open an issue and I'll see if I have the time to implement what you need.