# frozen_string_literal: true

module Cinch
  module Plugins
    class BasicCTCP
      include Cinch::Plugin

      DEFAULT_VERSION_REPLY = "IRCinch v#{Cinch::VERSION}".freeze
      private_constant :DEFAULT_VERSION_REPLY

      ctcp :version
      ctcp :time
      ctcp :ping
      ctcp :source
      ctcp :clientinfo

      def ctcp_version(m)
        m.ctcp_reply reply(:version) || DEFAULT_VERSION_REPLY if reply_to_ctcp?(:version)
      end

      def ctcp_time(m)
        m.ctcp_reply Time.now.strftime("%a %b %d %H:%M:%S %Z %Y") if reply_to_ctcp?(:time)
      end

      def ctcp_ping(m)
        m.ctcp_reply m.ctcp_args.join(" ") if reply_to_ctcp?(:ping)
      end

      def ctcp_source(m)
        m.ctcp_reply reply(:source) || "https://github.com/ircinchrb/ircinch" if reply_to_ctcp?(:source)
      end

      def ctcp_clientinfo(m)
        m.ctcp_reply reply(:clientinfo) || "ACTION PING VERSION TIME CLIENTINFO SOURCE" if reply_to_ctcp?(:clientinfo)
      end

      def reply_to_ctcp?(command)
        commands = config[:commands]
        commands.nil? || commands.include?(command)
      end

      private

      def reply(command)
        replies = config[:replies]
        replies[command] if replies
      end
    end
  end
end
