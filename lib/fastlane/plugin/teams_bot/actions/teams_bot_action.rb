require 'fastlane/action'

module Fastlane
  module Actions
    class TeamsBotAction < Action
      def self.run(params)
        payload = {
          "@type" => "MessageCard",
          "@context" => "http://schema.org/extensions",
          "themeColor" => params[:theme_color],
          "title" => params[:title],
          "summary" => params[:summary],
          "sections": [{
              "activityTitle": params[:activity_title],
              "activitySubtitle": params[:activity_subtitle],
              "activityImage": params[:activity_image],
              "text" => params[:text],
              "facts": params[:facts],
              "markdown": params[:use_markdown]
          }]
        }

        send_message(params[:teams_url], payload)
      end

      def self.send_message(url, payload)
        require 'net/http'
        require 'uri'
        
        json_headers = { 'Content-Type' => 'application/json' }
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        response = http.post(uri.path, payload.to_json, json_headers)
        is_message_success(response)
      end

      def self.is_message_success(response)
        if response.code.to_i == 200 && response.body.to_i == 1
          UI.message("🍾 The message was sent successfully")
          true
        else
          UI.user_error!("⚠️ An error occurred: #{response.body}")
        end
      end

      def self.available_options
        [
          # Card configuration
          FastlaneCore::ConfigItem.new(key: :theme_color,
                                       env_name: "TEAMS_MESSAGE_THEME_COLOR",
                                       description: "Theme color of the message card",
                                       optional: true,
                                       default_value: "321244"),

          FastlaneCore::ConfigItem.new(key: :title,
                                       env_name: "TEAMS_MESSAGE_TITLE",
                                       optional: false,
                                       description: "The title that should be displayed on Teams"),

          FastlaneCore::ConfigItem.new(key: :summary,
                                       env_name: "TEAMS_MESSAGE_SUMMARY",
                                       description: "The summary that should be displayed on Teams",
                                       optional: true,
                                       default_value: "summary"),

          # Activity Configuration
          FastlaneCore::ConfigItem.new(key: :activity_title,
                                       env_name: "TEAMS_MESSAGE_ACTIVITY_TITLE",
                                       optional: false,
                                       description: "A summary of your message"),

          FastlaneCore::ConfigItem.new(key: :activity_subtitle,
                                       env_name: "TEAMS_MESSAGE_ACTIVITY_SUBTITLE",
                                       optional: true,
                                       description: "A quick subtitle for your activity (date, project name, branch, ...)",
                                       default_value: ""),

          FastlaneCore::ConfigItem.new(key: :activity_image,
                                       env_name: "TEAMS_MESSAGE_ACTIVITY_IMAGE",
                                       sensitive: true,
                                       optional: true,
                                       description: "Display an image on your activity (project logo, company logo, ...)"),

          FastlaneCore::ConfigItem.new(key: :text,
                                       env_name: "TEAMS_MESSAGE_TEXT",
                                       description: "The message you want to display",
                                       optional: false),

          FastlaneCore::ConfigItem.new(key: :use_markdown,
                                       type: Boolean,
                                       env_name: "TEAMS_MESSAGE_USE_MARKDOWN",
                                       optional: true,
                                       description: "Define to use or not markdown",
                                       default_value: true),

          FastlaneCore::ConfigItem.new(key: :facts,
                                       type: Array,
                                       env_name: "TEAMS_MESSAGE_FACTS",
                                       description: "Optional facts (assigned to, due date, status, branch, environment, ...)",
                                       default_value: []),

          # Core Configuration
          FastlaneCore::ConfigItem.new(key: :teams_url,
                                       env_name: "TEAMS_MESSAGE_TEAMS_URL",
                                       sensitive: true,
                                       optional: false,
                                       description: "The URL of the incoming Webhook you created on your Microsoft Teams channel",
                                       verify_block: proc do |value|
                                         UI.user_error!("Invalid URL, must start with https://") unless value.start_with?("https://")
                                       end)
        ]
      end

      def self.example_code
        [
          'teams_bot(
            teams_url: "https://outlook.office.com/webhook/...",
            title: "Welcome from Fastlane",
            summary: "Integration is a success",
            text: "Hi there !! I am [Teams Bot](https://github.com/huextrat/fastlane-plugin-teams_bot). I can send messages on Microsoft Teams very easily from Fastlane.",
            activity_title: "Hey",
            activity_subtitle: "Working on Fastlane",
            activity_image: "https://seeklogo.com/images/F/fastlane-logo-6CA0B0B428-seeklogo.com.png",
            facts: [
              {
                "name" => "Environment",
                "value" => "Staging"
              },
              {
                "name" => "Branch",
                "value" => "Develop"
              }
            ],
            theme_color: "321244",
            use_markdown: true
          )'
        ]
      end

      def self.description
        "Easily send a message to a Microsoft Teams channel through the Webhook connector"
      end

      def self.details
        # Optional:
        "Send a message to a specific channel on your Microsoft Teams organization"
      end

      def self.authors
        ["Hugo EXTRAT"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
