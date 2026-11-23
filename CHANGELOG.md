# Changelog

## ircinch-basic_ctcp 1.1.2 (unreleased)

- Forked `cinch-basic_ctcp` as `ircinch-basic_ctcp`. The gem requires IRCinch 2.4.0 or later and Ruby 3.3 or later. Load it with `require "cinch/plugins/basic_ctcp"` and register `Cinch::Plugins::BasicCTCP`.
- Updated the default `VERSION` reply to report IRCinch and the default `SOURCE` reply to link to the IRCinch repository.
- Fixed `VERSION`, `SOURCE`, and `CLIENTINFO` replies when `:replies` is omitted. Partial overrides fall back to the built-in replies for the other commands.
- Reused the built-in `VERSION`, `SOURCE`, and `CLIENTINFO` reply strings, eliminated the empty hash allocation when `:replies` is omitted, and removed the unused `time` require.
- Added tests covering all five CTCP replies, custom replies, and command filtering.
- Updated the installation documentation and gem metadata.

## Original cinch-basic_ctcp releases

Historical entries are based on the published gems and the original repository's commit history. [RubyGems release archive](https://rubygems.org/gems/cinch-basic_ctcp/versions) · [Original repository](https://github.com/cinchrb/cinch-basic_ctcp)

### 1.1.1 (2016-02-22)

- Reissued 1.1.0 with the same packaged files and dependency requirements.

### 1.1.0 (2016-02-22)

- Added the `:replies` option for overriding `VERSION`, `SOURCE`, and `CLIENTINFO` replies.
- Fixed Markdown formatting so the installation example displays the `require` lines as code.

### 1.0.2 (2012-03-24)

- Updated the runtime dependency to the stable Cinch 2.x series (`~> 2.0`).

### 1.0.1 (2012-03-06)

- Relaxed the Cinch dependency to `>= 2.0.0.pre.1` so newer releases could be used.

### 1.0.0 (2012-03-04)

- Switched the runtime dependency from Cinch 1.x to `2.0.0.pre.1`.

### 0.0.1 (2011-01-30)

- Released the plugin for Cinch 1.x with replies for `CLIENTINFO`, `PING`, `SOURCE`, `TIME`, and `VERSION`.
- Added the `:commands` option to restrict which CTCP requests the plugin answers.
