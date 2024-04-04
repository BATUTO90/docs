---
keywords: docs, pipelines, tutorials, bazel
---

# Using Bazel on Buildkite

[Bazel](https://www.bazel.build/) is an open-source build and test tool similar to Make, Maven, and Gradle.
Bazel supports large codebases across multiple repositories, and large numbers of users.


## Using Bazel on Buildkite

1. [Install Bazel](https://docs.bazel.build/install.html) on one or more Buildkite Agents.
2. Add an empty [`WORKSPACE` file](https://docs.bazel.build/tutorial/cpp.html#set-up-the-workspace) to your project to mark it as a Bazel workspace.
3. Add a [`BUILD` file](https://docs.bazel.build/tutorial/cpp.html#understand-the-build-file) to your project to tell Bazel how to build it.
4. Add the Bazel build target(s) to your Buildkite [Pipeline](/docs/pipelines/defining-steps).

## Buildkite C++ Bazel example

We've made a short Bazel example which you can run and customize.

Make sure you're signed into your [Buildkite account](https://buildkite.com) and have access to a Buildkite Agent [running Bazel](https://docs.bazel.build/install.html), then click through to the example:

<a class="Docs__example-repo" href="https://github.com/buildkite/bazel-example">
  <span class="icon">:memo:</span>
  <span class="detail">
    <strong>Buildkite Bazel Example</strong>
    <span class="description">A Buildkite Bazel Example you can run and customize.</span>
    <span class="repo">github.com/buildkite/bazel-example</span>
  </span>
</a>

## Further reading

* The [Bazel C++ tutorial](https://docs.bazel.build/tutorial/cpp.html#refine-your-bazel-build) goes into more detail about how to configure more complex Bazel builds, covering multiple build targets and multiple packages.
* The Bazel [external dependencies docs](https://docs.bazel.build/external.html) show you how to build other local and remote repositories.
