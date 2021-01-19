require 'fastlane/action'
require_relative '../helper/teams_bot_helper'

module Fastlane
  module Actions
    class TeamsBotAction < Action
      def self.run(params)
        UI.message("The teams_bot plugin is working!")
      end

      def self.description
        "Easily alert a Microsoft Teams channel"
      end

      def self.authors
        ["Hugo EXTRAT"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "Send a message to a specific channel on your Microsoft Teams organization"
      end

      def self.available_options
        [
          # FastlaneCore::ConfigItem.new(key: :your_option,
          #                         env_name: "TEAMS_BOT_YOUR_OPTION",
          #                      description: "A description of your option",
          #                         optional: false,
          #                             type: String)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
