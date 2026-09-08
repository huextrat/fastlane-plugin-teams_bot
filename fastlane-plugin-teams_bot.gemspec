lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/teams_bot/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-teams_bot'
  spec.version       = Fastlane::TeamsBot::VERSION
  spec.author        = 'Hugo EXTRAT'
  spec.email         = 'extrat.h@gmail.com'

  spec.summary       = 'Easily alert a Microsoft Teams channel'
  spec.homepage      = "https://github.com/huextrat/fastlane-plugin-teams_bot"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w[README.md CHANGELOG.md LICENSE]
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 3.0'

  spec.metadata['bug_tracker_uri'] = 'https://github.com/huextrat/fastlane-plugin-teams_bot/issues'
  spec.metadata['changelog_uri'] = 'https://github.com/huextrat/fastlane-plugin-teams_bot/blob/main/CHANGELOG.md'
  spec.metadata['source_code_uri'] = 'https://github.com/huextrat/fastlane-plugin-teams_bot'
  spec.metadata['rubygems_mfa_required'] = 'true'

  # Don't add a dependency to fastlane or fastlane_re
  # since this would cause a circular dependency

  # spec.add_dependency 'your-dependency', '~> 1.0.0'
end
