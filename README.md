# Microsoft Teams Bot `fastlane` plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-teams_bot)
[![Gem Version](https://badge.fury.io/rb/fastlane-plugin-teams_bot.svg)](https://badge.fury.io/rb/fastlane-plugin-teams_bot)


## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-teams_bot`, add it to your project by running:

```bash
fastlane add_plugin teams_bot
```

## About teams_bot

This plugin sends MessageCard notifications to a Microsoft Teams channel from a fastlane lane.

Create a webhook with the Microsoft Teams **Workflows** app, then copy its complete HTTP POST URL. See Microsoft's guide to [create incoming webhooks with Workflows](https://learn.microsoft.com/en-us/microsoftteams/platform/webhooks-and-connectors/how-to/add-incoming-webhook#create-webhooks-using-workflows).

The generated URL contains required query parameters such as `api-version` and `sig`; pass the complete URL to `teams_url`.

> [!NOTE]
> Power Automate normally acknowledges a valid request with HTTP 202. This confirms that the workflow accepted the request for asynchronous processing, not that every later workflow step completed successfully.

## Usage

```ruby
teams_bot(
    teams_url: "<workflow webhook URL>",
    title: "Welcome from Fastlane",
    text: "Hi there !! I am [Teams Bot](https://github.com/huextrat/fastlane-plugin-teams_bot). I can send messages on Microsoft Teams very easily from Fastlane.",
    activity_title: "Hey",
    activity_image: "https://seeklogo.com/images/F/fastlane-logo-6CA0B0B428-seeklogo.com.png"
)
```

or

```ruby
teams_bot(
    teams_url: "<workflow webhook URL>",
    title: "Welcome from Fastlane",
    text: "Hi there !! I am [Teams Bot](https://github.com/huextrat/fastlane-plugin-teams_bot). I can send messages on Microsoft Teams very easily from Fastlane.",
    activity_title: "Hey",
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
    theme_color: "321244", # A custom RGB color
    use_markdown: true # Using markdown allowing you to add URL in your text
)
```

This code give the following message:

<img src="screenshots/1.png">

### Help

Once installed, information and help for an action can be printed out with this command:

```bash
fastlane action teams_bot
```

### `teams_bot`

| Key               | Description                | Env Var                    | Default |
|-------------------|----------------------------|----------------------------|---------|
| theme_color       | Theme color of the message card | TEAMS_MESSAGE_THEME_COLOR  | 321244  |
| title             | The title that should be displayed on Teams | TEAMS_MESSAGE_TITLE        |         |
| summary           | The summary that should be displayed on Teams | TEAMS_MESSAGE_SUMMARY      | summary |
| activity_title    | A summary of your message  | TEAMS_MESSAGE_ACTIVITY_TITLE  |         |
| activity_subtitle | A quick subtitle for your activity (date, project name, branch, ...)  | TEAMS_MESSAGE_ACTIVITY_SUBTITLE  | ''      |
| activity_image    | Display an image on your activity (project logo, company logo, ...)  | TEAMS_MESSAGE_ACTIVITY_IMAGE  |         |
| text              | The message you want to display    | TEAMS_MESSAGE_TEXT         |         |
| use_markdown      | Define to use or not markdown       | TEAMS_MESSAGE_USE_MARKDOWN  | true    |
| facts             | Optional facts (assigned to, due date, status, branch, environment, ...)   | TEAMS_MESSAGE_FACTS        | []      |
| teams_url         | The complete URL of the webhook workflow created for your Microsoft Teams channel | TEAMS_MESSAGE_TEAMS_URL |         |

## Example

Check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo, running `fastlane install_plugins` and `bundle exec fastlane test`.

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
