# Slack

The [Slack](https://slack.com/) notification service in Buildkite lets you receive notifications about your builds and jobs in your Slack workspace.

Configuring a Slack notification service will authorize access for your desired channel. By default, notifications will be sent to all configured Slack channels.

Setting up a notification service requires Buildkite organization admin access.

## Adding a notification service

In your [Buildkite organization's **Notification Services** settings](https://buildkite.com/organizations/-/services), add a Slack notification service:

<%= image "buildkite-add-slack.png", width: 1458/2, height: 142/2, alt: "Screenshot of the 'Add' button for adding a Slack service to Buildkite" %>

Click the **Add to Slack** button:

<%= image "buildkite-add-to-slack.png", width: 1458/2, height: 358/2, alt: "Screenshot of 'Add Slack Service' screen on Buildkite. It shows an 'Add to Slack' button, as well as the option to switch to a custom Webhook URL." %>

This will take you to Slack. Log in, choose a workspace, and grant Buildkite the ability to post in your chosen channel:

<%= image "buildkite-slack-oauth-screen.png", width: 1458/2, height: 1101/2, alt: "Screenshot of Slack's OAuth prompt, with Buildkite requesting access to your Slack workspace. It shows that Buildkite needs to know some information about you and your workspace, and asks you to choose a channel for Buildkite to post in." %>

Once you have granted access to your Slack workspace, give it a description, choose how the notifications should display, and select the type of notifications you want to receive:

<%= image "buildkite-slack-connected.png", width: 1458/2, height: 1540/2, alt: "Screenshot of Buildkite Slack Notification Settings, requesting a description, your choice of text or emoji message themes, which pipelines and branches to include, and which build states should trigger a notification" %>

> 🚧
> The default quota limit for the number of Slack notification services that can be added to an organization is 50. If you are an Enterprise customer and need higher quota limit, please reach out to support@buildkite.com. Alternatively, you can use a [Slack workspace](/docs/integrations/slack-workspace) to configure notifications, which only requires a single authorization, rather than many.


With the configuration above, you'll receive notifications at the pipeline level but not on the outcomes of individual steps. The **fixed builds** option ensures you're notified when a failed build next passes.

> 🚧
> To avoid duplicate notifications, if you're using the [`notify` YAML attribute](/docs/pipelines/notifications) for more fine grained control over your Slack notifications, ensure you've selected the **Only Some Pipelines...** option and have excluded that pipeline from receiving the default notifications.

## Changing channels

Once created, the Slack channel and workspace cannot be changed. To post to a different channel or workspace, create a new notification service. Alternatively, you can use a [Slack workspace](/docs/integrations/slack-workspace) to configure notifications in YAML.

## Conditional notifications

By default, notifications are sent to all configured Slack channels. For more control over when each channel receives notifications, use the `notify` YAML attribute in your `pipeline.yml` file.

See the [Slack channel message](/docs/pipelines/notifications#slack-channel-and-direct-messages) section of the Notifications guide for the configuration information.

## Upgrading a legacy Slack service

Slack stopped accepting notifications from legacy Buildkite services on January 10th, 2020.

If you have Slack set up with a legacy service or are no longer receiving notifications, add a new Slack notification service in your [Buildkite organization's **Notification Services** settings](https://buildkite.com/organizations/-/services).

### Identify where your existing services post notifications

Compare the webhook URLs from your Buildkite notification service with your Slack integration to find your existing notification settings.

Finding your Buildkite webhook URL: Click on the Slack notification service in Buildkite, the webhook URL will be listed here.

Finding your Slack integration's webhook URL:

1. In your Slack workspace's App Directory, click the **Manage** button and find the Buildkite app.
1. Click through the Buildkite app, then click the pencil button to edit your configuration.
1. The webhook URL will be listed under **Integration Settings**.

### Confirm which pipelines, and which events, are posted

Once you've found the matching Buildkite service and Slack app, confirm where and what you're posting to Slack. Take note of the events and pipelines so that you can set up a new notification service.

### Create a new Slack notification service which posts

Using the instructions above, [add a new Buildkite notification service](/docs/integrations/slack#adding-a-notification-service) with the same settings as the legacy integration.

#### Slack privacy policy

For more details, please checkout the [Slack Marketplace privacy policy](https://api.slack.com/slack-marketplace/guidelines#privacy).
