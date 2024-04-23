# Organizations API

The organizations API:

- allows you to list organizations and retrieve information about an organization

- forms the basis of several more Buildkite REST API endpoints, such as those for [pipelines](/docs/apis/rest-api/pipelines) and [teams](/docs/apis/rest-api/teams).

## List organizations

Returns a [paginated list](<%= paginated_resource_docs_url %>) of organizations accessible by the user's access token.

```bash
curl -H "Authorization: Bearer $TOKEN" \
  -X GET "https://api.buildkite.com/v2/organizations"
```

```json
[
  {
    "id": "bb3125de-4dc9-44cf-ad18-65d2b71a5a34",
    "graphql_id": "T3JnYW5pemF0aW9uLS0tOGEzMjAwOTMtMjE4OC00MmNiLWI5ZGQtNzE4NjZjZTYyYjA4",
    "url": "https://api.buildkite.com/v2/organizations/my-great-org",
    "web_url": "https://buildkite.com/my-great-org",
    "name": "My Great Org",
    "slug": "my-great-org",
    "pipelines_url": "https://api.buildkite.com/v2/organizations/my-great-org/pipelines",
    "agents_url": "https://api.buildkite.com/v2/organizations/my-great-org/agents",
    "emojis_url": "https://api.buildkite.com/v2/organizations/my-great-org/emojis",
    "created_at": "2015-05-09T21:05:59.874Z"
  }
]
```

Required scope: `read_organizations`

Success response: `200 OK`

## Get an organization

```bash
curl -H "Authorization: Bearer $TOKEN" \
  -X GET "https://api.buildkite.com/v2/organizations/{org.slug}"
```

```json
{
  "id": "bb3125de-4dc9-44cf-ad18-65d2b71a5a34",
  "graphql_id": "T3JnYW5pemF0aW9uLS0tOGEzMjAwOTMtMjE4OC00MmNiLWI5ZGQtNzE4NjZjZTYyYjA4",
  "url": "https://api.buildkite.com/v2/organizations/my-great-org",
  "web_url": "https://buildkite.com/my-great-org",
  "name": "My Great Org",
  "slug": "my-great-org",
  "pipelines_url": "https://api.buildkite.com/v2/organizations/my-great-org/pipelines",
  "agents_url": "https://api.buildkite.com/v2/organizations/my-great-org/agents",
  "emojis_url": "https://api.buildkite.com/v2/organizations/my-great-org/emojis",
  "created_at": "2015-05-09T21:05:59.874Z"
}
```

Required scope: `read_organizations`

Success response: `200 OK`
