# Public test suites

If you're working on an open-source project, and want the whole world to be able to see your test analytics, you can make your test suite public.


Making a suite public gives read-only access to all users. This means that users who are unauthenticated, or belong to another organization, are able to view:

- All test suite data
- Run results
- Test analytics
- Test executions
- Test execution data. For those using Buildkite's ruby test collector this includes SQL query data, HTTP request paths and the execution timeline. 
- Environment variables that occur on each run:
  + `commit_sha` `branch` `message` `url` `number` `job_id`

Before making a suite public, you should verify that runs do not expose sensitive information in their logs or environment variables — this applies to both new and historical runs.

## Make a test suite public using the UI

A test suite can be made public in the _Settings_ of a suite:

<%= image "settings.png", width: 1960/2, height: 630/2, alt: "Public test suite settings" %>

Permission to make a test suite public is reserved for organization admins initially. Admins are able to extend this permission to all organization members via the _Security_ tab in the organization settings.

<%= image "security.png", width: 1960/2, height: 630/2, alt: "Public test suite settings" %>

