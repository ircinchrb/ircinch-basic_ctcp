# IRCinch Basic CTCP

## Description

`ircinch-basic_ctcp` lets your IRCinch bot answer common Client-to-Client Protocol (CTCP) requests. Add the plugin to your bot to enable all five replies, or configure which requests it answers.

| Request | Default reply |
| --- | --- |
| `CLIENTINFO` | Lists supported CTCP commands. |
| `PING` | Echoes the request's arguments. |
| `SOURCE` | Links to the IRCinch source code. |
| `TIME` | Reports the bot's local time. |
| `VERSION` | Reports the IRCinch version. |

## Installation

The gem requires Ruby 3.3 or newer and IRCinch 2.4.0 or newer.

### RubyGems

Install a published release with `gem install`. RubyGems installs IRCinch as a dependency.

```sh
gem install ircinch-basic_ctcp
```

### Bundler

Add the plugin to your `Gemfile` and run `bundle install`.

```ruby
gem "ircinch-basic_ctcp", require: false
```

To try a local checkout, add `path: "../ircinch-basic_ctcp"` to the gem entry and adjust the path to match your checkout.

## Example

Load `ircinch` first, then require the plugin and add `Cinch::Plugins::BasicCTCP` to your bot's plugin list.

```ruby
require "ircinch"
require "cinch/plugins/basic_ctcp"

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.libera.chat"
    c.nick = "ctcp_example_bot"
    c.channels = ["#ircinch-bots"]
    c.plugins.plugins = [Cinch::Plugins::BasicCTCP]
  end
end

bot.start
```

Use your own nick and channel when trying the example. For help configuring your bot, see the [IRCinch Getting Started guide](https://github.com/ircinchrb/ircinch/blob/main/docs/getting_started.md).

## Configuration

- `:commands` takes an array of lowercase symbols. Omit it to enable all five replies, or set it to `[]` to disable them all.
- `:replies` takes a hash of custom replies for `:version`, `:source`, and `:clientinfo`. Omitted keys use the built-in replies.

Add this inside your bot's `configure` block to answer only `VERSION` and `TIME` with a custom `VERSION` reply.

```ruby
c.plugins.options[Cinch::Plugins::BasicCTCP] = {
  commands: [:version, :time],
  replies: {version: "My bot v1.0"}
}
```

## Code of Conduct

Project discussions and contributions follow the [Code of Conduct](CODE_OF_CONDUCT.md).

## Contributing

Bug reports and pull requests are welcome. See the [changelog](CHANGELOG.md) for release history.

### Development

From a checkout of the repository, install the development dependencies and run the tests.

```sh
bundle install
bundle exec rake test
```

SimpleCov writes the HTML report to `coverage/index.html`. Run `bundle exec standardrb` to check code style.

## License

The gem is available under the [MIT License](LICENSE.txt).
