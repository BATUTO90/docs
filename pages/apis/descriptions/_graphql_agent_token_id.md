- `token-id` (required) can only be obtained using the APIs, by running the [getClustersAgentTokenIds](/docs/apis/graphql/schemas/query/organization) query, to obtain the organization's clusters and each of their agent tokens' `id` values in the response. For example:

      ```graphql
      query getClustersAgentTokenIds {
        organization(slug: "organization-slug") {
          clusters(first: 10) {
            edges {
              node {
                name
                id
                agentTokens(first: 10) {
                  edges {
                    node {
                      description
                      id
                    }
                  }
                }
              }
            }
          }
        }
      }
      ```
