# Agent tokens

A Buildkite agent requires an agent token to connect to Buildkite and register for work. Agent tokens connect to Buildkite via a [cluster](/docs/clusters/overview), and can be accessed from the cluster's _Agent Tokens_ page.

If you are managing agents in an unclustered environment, refer to [unclustered tokens](/docs/agent/v3/unclustered-tokens) instead.

## The initial agent token

When you create a new organization in Buildkite, an initial agent token is created (called _Initial agent token_ within the _Default cluster_). This token can be used for testing and development and is only revealed once during the organization setup process. It's recommended that you [create new, specific tokens](#create-a-token) for each new environment.

## Using and storing tokens

An agent token is used by the Buildkite Agent's [start](/docs/agent/v3/cli-start#starting-an-agent) command, and can be provided on the command line, set in the [configuration file](/docs/agent/v3/configuration), or provided using the [environment variable](/docs/pipelines/environment-variables) `BUILDKITE_AGENT_TOKEN`.

It's recommended you use your platform's secret storage (such as the [AWS Systems Manager Parameter Store](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-paramstore.html)) to allow for easier rollover and management of your agent tokens.

## Create a token

New agent tokens can be created using the [_Agent Tokens_ page of a cluster](#create-a-token-using-the-buildkite-interface), as well as the [REST API's](#create-a-token-using-the-rest-api) or [GraphQL API's](#create-a-token-using-the-graphql-api) create agent token feature.

> 📘 An agent token's value is only displayed once
> As soon as the agent token's value is displayed, copy its value and save it in a secure location.
> If you forget to do this, you'll need to create a new token to obtain its value.

It is possible to create multiple agent tokens (for your Default cluster or any other cluster in your Buildkite organization) using the processes described in this section.

### Using the Buildkite interface

To create an agent token for a cluster using the Buildkite interface:

1. Select _Agents_ in the global navigation to access the _Clusters_ page.
1. Select the cluster that will be associated with this agent token.
1. Select _Agent Tokens_ > _New Token_.
1. In the _Description_ field, enter an appropriate description for the agent token.

    **Note:** The token description should clearly identify the environment the token is intended to be used for (for example, `Read-only token for static site generator`), as it is listed on the _Agent tokens_ page of your specific cluster the agent connects to. This page can be accessed by selecting _Agents_ (in the global navigation) > the specific cluster > _Agent Tokens_.

1. If you need to restrict which network addresses are allowed to use this agent token, enter these addresses (using [CIDR notation](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing)) into the _Allowed IP Addresses_ field.

    **Note:** Leave this field empty if there is no need to restrict the use of this agent token by network address. Learn more about this feature in [Restrict an agent token's access by IP address](/docs/clusters/manage-clusters#restrict-an-agent-tokens-access-by-ip-address).

1. Select _Create Token_.

    Follow the instructions to copy and save your token to a secure location and click _Okay, I'm done!_. The new agent token appears on the cluster's _Agent Tokens_ page.

### Using the REST API

To [create an agent token](/docs/apis/rest-api/clusters#agent-tokens-create-a-token) using the [REST API](/docs/apis/rest-api), run the following example `curl` command:

```curl
curl -H "Authorization: Bearer $TOKEN" \
  -X POST "https://api.buildkite.com/v2/organizations/{org.slug}/clusters/{cluster.id}/tokens" \
  -H "Content-Type: application/json" \
  -d '{
    "description": "A description",
    "allowed_ip_addresses": "0.0.0.0/0"
  }'
```

where:

<%= render_markdown partial: 'apis/descriptions/rest_access_token' %>

<%= render_markdown partial: 'apis/descriptions/rest_org_slug' %>

<%= render_markdown partial: 'apis/descriptions/rest_cluster_id' %>

<!--alex ignore clearly-->

- <%= render_markdown partial: 'apis/descriptions/rest_agent_token_description' %>

- <%= render_markdown partial: 'apis/descriptions/common_allowed_ip_addresses' %>

The new agent token appears on the cluster's _Agent Tokens_ page.

### Using the GraphQL API

To [create an agent token](/docs/apis/graphql/schemas/mutation/clusteragenttokencreate) using the [GraphQL API](/docs/apis/graphql-api), run the following example mutation:

```graphql
mutation {
  clusterAgentTokenCreate(
    input: {
      organizationId: "organization-id"
      clusterId: "cluster-id"
      description: "A description"
      allowedIpAddresses: "0.0.0.0/0"
    }
  ) {
    clusterAgentToken {
      id
      uuid
      description
      allowedIpAddresses
      cluster {
        id
        uuid
        organization {
          id
          uuid
        }
      }
      createdBy {
        id
        uuid
        email
      }
    }
  }
}
```

where:

<%= render_markdown partial: 'apis/descriptions/graphql_organization_id' %>

<%= render_markdown partial: 'apis/descriptions/graphql_cluster_id' %>

- <%= render_markdown partial: 'apis/descriptions/graphql_agent_token_description' %>

- <%= render_markdown partial: 'apis/descriptions/common_allowed_ip_addresses' %>

The new agent token appears on the cluster's _Agent Tokens_ page.

## Update a token

Agent tokens can be updated using the [_Agent Tokens_ page of a cluster](#update-a-token-using-the-buildkite-interface), as well as the [REST API's](#update-a-token-using-the-rest-api) or [GraphQL API's](#update-a-token-using-the-graphql-api) revoke agent token feature.

Only the _Description_ and _Allowed IP Addresses_ of an existing agent token can be updated.

### Using the Buildkite interface

To update a cluster's agent token using the Buildkite interface:

1. Select _Agents_ in the global navigation to access the _Clusters_ page.
1. Select the cluster containing the agent token to update.
1. Select _Agent Tokens_ and on this page, expand the agent token to update.
1. Select _Edit_ and update the following fields as required:
    * _Description_ should clearly identify the environment the token is intended to be used for (for example, `Read-only token for static site generator`), as it is listed on the _Agent tokens_ page of your specific cluster the agent connects to. This page can be accessed by selecting _Agents_ (in the global navigation) > the specific cluster > _Agent Tokens_.
    * _Allowed IP Addresses_ is/are the IP addresses which agents must be accessible through to access this agent token and be able to connect to Buildkite via your cluster. Use space-separated [CIDR notation](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) to enter IP addresses for this field value.

        Leave this field empty if there is no need to restrict the use of this agent token by network address. Learn more about this feature in [Restrict an agent token's access by IP address](/docs/clusters/manage-clusters#restrict-an-agent-tokens-access-by-ip-address).

1. Select _Save Token_ to save your changes.

    The agent token's updates will appear on the cluster's _Agent Tokens_ page.

### Using the REST API

To [update an agent token](/docs/apis/rest-api/clusters#agent-tokens-update-a-token) using the [REST API](/docs/apis/rest-api), run the following example `curl` command:

```curl
curl -H "Authorization: Bearer $TOKEN" \
  -X PUT "https://api.buildkite.com/v2/organizations/{org.slug}/clusters/{cluster.id}/tokens/{id}" \
  -H "Content-Type: application/json" \
  -d '{
    "description": "A description",
    "allowed_ip_addresses": "202.144.0.0/24 198.51.100.12"
  }'
```

where:

<%= render_markdown partial: 'apis/descriptions/rest_access_token' %>

<%= render_markdown partial: 'apis/descriptions/rest_org_slug' %>

<%= render_markdown partial: 'apis/descriptions/rest_cluster_id' %>

<%= render_markdown partial: 'apis/descriptions/rest_agent_token_id' %>

- <%= render_markdown partial: 'apis/descriptions/rest_agent_token_description' %>

- <%= render_markdown partial: 'apis/descriptions/common_allowed_ip_addresses' %>

    This field can be omitted (where the default value is `0.0.0.0/0`) if there is no need to restrict the use of this agent token by network address. Learn more about this feature in [Restrict an agent token's access by IP address](/docs/clusters/manage-clusters#restrict-an-agent-tokens-access-by-ip-address).

### Using the GraphQL API

To [update an agent token](/docs/apis/graphql/schemas/mutation/clusteragenttokenupdate) using the [GraphQL API](/docs/apis/graphql-api), run the following example mutation:

```graphql
mutation {
  clusterAgentTokenUpdate(
    input: {
      organizationId: "organization-id"
      id: "token-id"
      description: "A description"
      allowedIpAddresses: "202.144.0.0/24 198.51.100.12"
    }
  ) {
    clusterAgentToken {
      id
      uuid
      description
      allowedIpAddresses
      cluster {
        id
        uuid
        organization {
          id
          uuid
        }
      }
      createdBy {
        id
        uuid
        email
      }
    }
  }
}
```

where:

<%= render_markdown partial: 'apis/descriptions/graphql_organization_id' %>

<%= render_markdown partial: 'apis/descriptions/graphql_agent_token_id' %>

- <%= render_markdown partial: 'apis/descriptions/graphql_agent_token_description' %>

    If you do not need to change the existing `description` value, specify the existing field value in this request.

- <%= render_markdown partial: 'apis/descriptions/common_allowed_ip_addresses' %>

    This field can be omitted (where the default value is `0.0.0.0/0`) if there is no need to restrict the use of this agent token by network address. Learn more about this feature in [Restrict an agent token's access by IP address](/docs/clusters/manage-clusters#restrict-an-agent-tokens-access-by-ip-address).

The agent token's updates will appear on the cluster's _Agent Tokens_ page.

## Revoke a token

Agent tokens can be revoked using the [_Agent Tokens_ page of a cluster](#revoke-a-token-using-the-buildkite-interface), as well as the [REST API's](#revoke-a-token-using-the-rest-api) or [GraphQL API's](#revoke-a-token-using-the-graphql-api) revoke agent token feature.

Once a token is revoked, no new agents will be able to start with that token. Revoking a token does not affect any connected agents.

### Using the Buildkite interface

To revoke a cluster's agent token using the Buildkite interface:

1. Select _Agents_ in the global navigation to access the _Clusters_ page.
1. Select the cluster containing the agent token to revoke.
1. Select _Agent Tokens_ and on this page, expand the agent token to revoke.
1. Select _Revoke_ > _Revoke Token_ in the confirmation message.

### Using the REST API

To [revoke an agent token](/docs/apis/rest-api/clusters#agent-tokens-revoke-a-token) using the [REST API](/docs/apis/rest-api), run the following example `curl` command:

```curl
curl -H "Authorization: Bearer $TOKEN" \
  -X DELETE "https://api.buildkite.com/v2/organizations/{org.slug}/clusters/{cluster.id}/tokens/{id}"
```

where:

<%= render_markdown partial: 'apis/descriptions/rest_access_token' %>

<%= render_markdown partial: 'apis/descriptions/rest_org_slug' %>

<%= render_markdown partial: 'apis/descriptions/rest_cluster_id' %>

<%= render_markdown partial: 'apis/descriptions/rest_agent_token_id' %>

### Using the GraphQL API

To [revoke an agent token](/docs/apis/graphql/schemas/mutation/clusteragenttokenrevoke) using the [GraphQL API](/docs/apis/graphql-api), run the following example mutation:

```graphql
mutation {
  clusterAgentTokenRevoke(
    input: {
      organizationId: "organization-id"
      id: "token-id"
    }
  ) {
    deletedClusterAgentTokenId
  }
}
```

where:

<%= render_markdown partial: 'apis/descriptions/graphql_organization_id' %>

<%= render_markdown partial: 'apis/descriptions/graphql_agent_token_id' %>

## Scope of access

An agent token is specific to the cluster it was associated when created (within a Buildkite organization), and can be used to register an agent with any [queue](/docs/agent/v3/queues) defined in that cluster. Agent tokens can not be shared between different clusters within an organization, or between different organizations.

## Session and job tokens

During registration, the agent exchanges its agent token for a session token. The session token lasts for the lifetime of the agent and is used to request and start new jobs. When each job is started, the agent gets a job token specific to that job. The job token is exposed to the job as the [environment variable](/docs/pipelines/environment-variables) `BUILDKITE_AGENT_ACCESS_TOKEN`, and is used by various CLI commands (including the [annotate](/docs/agent/v3/cli-annotate), [artifact](/docs/agent/v3/cli-artifact), [meta-data](/docs/agent/v3/cli-meta-data), and [pipeline](/docs/agent/v3/cli-pipeline) commands).

Job tokens are valid until the job finishes. To ensure job tokens have a limited lifetime, you can set a default or maximum [command timeout](/docs/pipelines/build-timeouts#command-timeouts).

<table>
  <tr>
    <th>Token type</th>
    <th>Use</th>
    <th>Lifetime</th>
  </tr>
  <tr>
    <td>Agent token</td>
    <td>Registering new agents.</td>
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

>📘 Job tokens not supported in agents prior to v3.39.0
> Agents prior to v3.39.0 use the session token for the `BUILDKITE_AGENT_ACCESS_TOKEN` environment variable and the job APIs.
