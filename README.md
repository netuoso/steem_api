# SteemApi

[![Gem Version](https://badge.fury.io/rb/steem_api.svg)](https://badge.fury.io/rb/steem_api)

### How To Use (Rails 4+)
- Add Gem to Gemfile
	*	`gem 'steem_api', '~> 1.1'`
- Bundle Install Gems
	* `bundle install`

### How To Use (Standalone)
- `gem install steem_api`
- `irb`
- `require 'steem_api'`
- `SteemApi::Comment.last`

### Models
- Account
- Block
- Comment
- Token
- Transaction

### Followers

How to query today's followers:

```ruby
followers = SteemApi::Tx::Custom::Follow
followers.following(:ned).today.count
```

### Resteem

How to query today's "resteems":

```ruby
reblogs = SteemApi::Tx::Custom::Reblog
reblogs.author(:netuoso).today.count
```

### How To Contribute
- Fork this repo
- Branch off Master and make your changes
- Submit a PR to this repo's Master branch

### License
- [WTFPL](LICENSE.txt)
