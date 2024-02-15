# User API

The User API endpoint allows you to inspect details about the user account that owns the API token that is currently being used.

## Get the current user

Returns basic details about the user account that sent the request.

```bash
curl -H "Authorization: Bearer $BUILDKITE_TOKEN" "https://api.buildkite.com/v2/user"
```

```json
{
    "id": "abc123-4567-8910-...",
    "graphql_id": "VXNlci0tLWU1N2ZiYTBmLWFiMTQtNGNjMC1iYjViLTY5NTc3NGZmYmZiZQ==",
    "name": "John Smith",
    "email": "john.smith@example.com",
    "avatar_url": "https://www.gravatar.com/avatar/abc123...",
    "created_at": "2012-03-04T56:07:08.910Z"
}
```

Required scope: `read_user`

Success response: `200 OK`
