# Unclustered agent tokens

> 🚧 This page documents a deprecated feature of Buildkite
> Previously, agents only connected to Buildkite directly via a token which was created and managed by the processes described on this page. These tokens are now a deprecated feature of Buildkite, and are referred to as _unclustered agent tokens_. Unclustered agent tokens, however, are still available to customers who have not yet migrated their pipelines across to a [cluster](/docs/clusters/overview).
> Agent tokens are now associated with clusters, such that these tokens connect to Buildkite through a specific cluster within an organization. Refer to the main [agent token](/docs/agent/v3/tokens) for details on how to create agent tokens for clusters.
> Any new Buildkite organizations created after the official release of clusters on February 26, 2024 will not have the ability to create unclustered agents. Therefore, unclustered agent tokens will not be relevant to these organizations.

Any Buildkite organization created before February 26, 2024 has an _Unclustered_ area for managing _unclustered agents_ (accessible through _Agents_ > _Unclustered_ of the Buildkite interface), where an _unclustered agent_ refers to any agent that is not associated with a cluster.

A Buildkite agent requires a token to connect to Buildkite and register for work. If you need to connect an _unclustered agent_ to Buildkite, then you need to create an _unclustered agent token_ to do so.

## The default token

<!-- Is this section still valid? Should this instead be called the 'initial unclustered agent token'? -->

Your Buildkite organization's unclustered agent tokens area (accessible through _Agents_ > _Unclustered_ > _Agent Tokens_) may have the _Default agent registration token_, which is the original default token when your organization was created. If you had previously saved this token's value in a safe place, this token can be used for testing and development. However, it's recommended that you [create new, specific tokens](#creating-tokens) for each new environment.

## Using and storing tokens

An unclustered agent token is used by the Buildkite agent's [start](/docs/agent/v3/cli-start#starting-an-agent) command, and can be provided on the command line, set in the [configuration file](/docs/agent/v3/configuration), or provided using the [environment variable](/docs/pipelines/environment-variables) `BUILDKITE_AGENT_TOKEN`.

It's recommended you use your platform's secret storage (such as the [AWS Systems Manager Parameter Store](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-paramstore.html)) to allow for easier rollover and management of your agent tokens.

## Creating tokens

New unclustered agent tokens can be created using the [GraphQL API](/docs/apis/graphql-api) with the `agentTokenCreate` mutation.

For example:

```graphql
mutation {
  agentTokenCreate(input: {
    organizationID: "organization-id",
    description: "A description"
  }) {
    tokenValue
    agentTokenEdge {
      node {
        id
      }
    }
  }
}
```

> 📘 An unclustered agent token's value is only displayed once
> As soon as the unclustered agent token's value is displayed, copy its value and save it in a secure location.
> If you forget to do this, you'll need to create a new token to obtain its value.

You can find your `organization-id` in your Buildkite organization settings page, or by running the following GrapqQL query:

```graphql
query GetOrgID {
  organization(slug: "organization-slug") {
    id
  }
}
```

<!--alex ignore clearly-->

The token description should clearly identify the environment the token is intended to be used for (for example, `Read-only token for static site generator`), and is listed on the _Agent tokens_ page of the _Agents_ > _Unclustered_ area. (This page is accessible through _Agents_ > _Unclustered_ > _Agent Tokens_.)

It is possible to create multiple unclustered agent tokens using the GraphQL API.

## Revoking tokens

Unclustered agent tokens can be revoked using the [GraphQL API](/docs/apis/graphql/cookbooks/agents#revoke-an-unclustered-agent-token) query with the `agentTokenRevoke ` mutation.

You need to pass your unclustered agent token as the ID in the mutation.

First, you can retrieve a list of agent token IDs using this query:

```graphql
query GetAgentTokenID {
  organization(slug: "organization-slug") {
    agentTokens(first:50) {
      edges {
        node {
          id
          uuid
          description
        }
      }
    }
  }
}
```

Then, using the token ID, revoke the unclustered agent token:

```graphql
mutation {
  agentTokenRevoke(input: {
    id: "token-id",
    reason: "A reason"
  }) {
    agentToken {
      description
      revokedAt
      revokedReason
    }
  }
}
```

Once a token is revoked, no new agents will be able to start with that token. Revoking a token does not affect any connected agents.

## Scope of access

Unclustered agent tokens are specific to each Buildkite organization (created before February 26, 2024), and can be used to register an agent with any [unclustered queue](/docs/agent/v3/queues). Unclustered agent tokens can not be shared between organizations.

## Session and job tokens

During registration, the unclustered agent exchanges its unclustered agent token for a session token. The session token lasts for the lifetime of the agent and is used to request and start new jobs. When each job is started, the unclustered agent gets a job token specific to that job. The job token is exposed to the job as the [environment variable](/docs/pipelines/environment-variables) `BUILDKITE_AGENT_ACCESS_TOKEN`, and is used by various CLI commands (including the [annotate](/docs/agent/v3/cli-annotate), [artifact](/docs/agent/v3/cli-artifact), [meta-data](/docs/agent/v3/cli-meta-data), and [pipeline](/docs/agent/v3/cli-pipeline) commands).

Job tokens are valid until the job finishes. To ensure job tokens have a limited lifetime, you can set a default or maximum [command timeout](/docs/pipelines/build-timeouts#command-timeouts).

<table>
  <tr>
    <th>Token type</th>
    <th>Use</th>
    <th>Lifetime</th>
  </tr>
  <tr>
    <td>Unclustered agent token</td>
    <td>Registering new unclustered agents.</td>
    <td>Forever unless manually revoked.</td>
  </tr>
  <tr>
    <td>Session token</td>
    <td>Agent lifecycle APIs and starting jobs.</td>
    <td>Until the agent disconnects.</td>
  </tr>
  <tr>
    <td>Job token</td>
    <td>Job APIs (including <a href="/docs/agent/v3/cli-annotate">annotate</a>,  <a href="/docs/agent/v3/cli-artifact">artifact</a>,  <a href="/docs/agent/v3/cli-meta-data">meta-data</a> and  <a href="/docs/agent/v3/cli-pipeline">pipeline</a> commands).</td>
    <td>Until the job finishes.</td>
  </tr>
</table>

> 📘 Job tokens not supported in agents prior to v3.39.0
> Agents prior to v3.39.0 use the session token for the `BUILDKITE_AGENT_ACCESS_TOKEN` environment variable and the job APIs.
