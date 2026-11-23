# frozen_string_literal: true

require_relative "test_helper"
require "cinch/plugins/basic_ctcp"

class BasicCTCPTest < Minitest::Test
  Message = Struct.new(:ctcp_args, :replies) do
    def ctcp_reply(text)
      replies << text
    end
  end

  def setup
    bot = Cinch::Bot.new
    plugin_class = Cinch::Plugins::BasicCTCP
    bot.plugins.register_plugins([plugin_class])
    @plugin = bot.plugins.fetch(0)
    @options = bot.config.plugins.options[plugin_class]
  end

  def test_default_replies_without_configuration
    assert_equal ["IRCinch v#{Cinch::VERSION}"], replies_for(:version)
    assert_equal ["https://github.com/ircinchrb/ircinch"], replies_for(:source)
    assert_equal ["ACTION PING VERSION TIME CLIENTINFO SOURCE"], replies_for(:clientinfo)
  end

  def test_time_uses_the_ctcp_reply_format
    replies = replies_for(:time)
    assert_equal 1, replies.size
    assert_match(/\A[A-Z][a-z]{2} [A-Z][a-z]{2} \d{2} \d{2}:\d{2}:\d{2} .* \d{4}\z/, replies.first)
  end

  def test_ping_echoes_the_arguments
    assert_equal ["one two"], replies_for(:ping, ["one", "two"])
    assert_equal [""], replies_for(:ping)
  end

  def test_custom_replies_override_defaults
    @options[:replies] = {version: "My bot", source: "https://example.test/bot", clientinfo: "PING VERSION"}

    assert_equal ["My bot"], replies_for(:version)
    assert_equal ["https://example.test/bot"], replies_for(:source)
    assert_equal ["PING VERSION"], replies_for(:clientinfo)
  end

  def test_partial_overrides_fall_back_to_defaults
    @options[:replies] = {version: "My bot"}

    assert_equal ["My bot"], replies_for(:version)
    assert_equal ["https://github.com/ircinchrb/ircinch"], replies_for(:source)
  end

  def test_only_configured_commands_get_replies
    @options[:commands] = [:version]

    assert_equal ["IRCinch v#{Cinch::VERSION}"], replies_for(:version)
    %i[time ping source clientinfo].each do |command|
      assert_empty replies_for(command)
    end
  end

  def test_empty_command_list_disables_all_replies
    @options[:commands] = []

    %i[version time ping source clientinfo].each do |command|
      assert_empty replies_for(command)
    end
  end

  private

  def replies_for(command, args = [])
    message = Message.new(args, [])
    @plugin.public_send("ctcp_#{command}", message)
    message.replies
  end
end
