# Buildkite Agent job queues

Each pipeline has the ability to separate jobs using queues. This allows you to isolate a set of jobs and/or agents, making sure they only run jobs that are intended to be assigned to them.

Common use cases for queues include deployment agents, and pools of agents for specific pipelines or teams.

## The default queue

If you don't configure a queue for your agent by setting an [agent tag](/docs/agent/v3/cli-start#setting-tags) of `queue=my_example_queue` it will accept jobs from the default queue as if you had set `queue=default`.

## Setting an agent's queue

An agent's queue is configured using an [agent tag](/docs/agent/v3/cli-start#setting-tags), which can be changed using the command line flag, an environment variable, or the config file.

Agents can listen on a single queue or on multiple queues. You can add as many extra `queue` tags as are required.

In the below example using the `--tags` flag of the `buildkite-agent start` command, two queues are specified which will result in the agent listening on both the `building` and `testing` queues:

```
buildkite-agent start --tags "queue=building,queue=testing"
```

<%= image "agent-queues.png", width: 1182/2, height: 160/2, alt: "Screenshot of an agent's tags showing both building and testing queues" %>

> 🚧 Configuring cluster queues
> If you have [Clusters](/docs/clusters/overview) enabled and are configuring your agent with a _cluster queue_, you need to create the cluster queue first. See [Create a cluster queue](/docs/clusters/manage-queues#create-a-queue) for more information.

## Targeting a queue

Target specific queues using the `agents` attribute on your pipeline steps or at the root level for the entire pipeline.

For example, the following pipeline would run on the `priority` queue as determined by the root level `agents` attribute (and ignores the agents running the `default` queue). The `tests.sh` build step matches only agents running on the `deploy` queue.

```yaml
agents:
  queue: "priority"

steps:
  - command: echo "hello"

  - command: tests.sh
    agents:
      queue: "deploy"
```

## Alternative methods

[Branch patterns](/docs/pipelines/branch-configuration) are another way to control what work is done. You can use branch patterns to determine which pipelines and steps run based on the branch name.
