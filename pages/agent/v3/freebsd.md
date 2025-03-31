# Installing Buildkite Agent on FreeBSD

You can install Buildkite Agent on most FreeBSD systems.

## Installation

The folks at [FreeBSD](https://www.freebsd.org/) have made it easy to install Buildkite Agent using the `pkg` package manager.

```shell
pkg install buildkite-agent
```

Configure your [agent token](https://buildkite.com/docs/agent/v3/tokens):

```shell
sudo sed -i "s/xxx/INSERT-YOUR-AGENT-TOKEN-HERE/g" /usr/local/etc/buildkite/buildkite-agent.cfg
```

Then, start the agent:

```shell
buildkite-agent start
```

Alternatively you can follow the [manual installation instructions](installation).

## SSH key configuration

SSH keys should be copied to (or generated into) `~/.ssh/` for the user the agent is running as. For example, to generate a new private key which you can add to your source code host:

```bash
$ mkdir -p ~/.ssh && cd ~/.ssh
$ ssh-keygen -t rsa -b 4096 -C "build@myorg.com"
```

See the [Agent SSH keys](/docs/agent/v3/ssh-keys) documentation for more details.

## File locations

* Configuration: `/usr/local/etc/buildkite/buildkite-agent.cfg`
* Agent Hooks: `/usr/local/etc/buildkite/hooks`
* Builds: `/usr/local/var/buildkite/builds`
* SSH keys: `~/.ssh`

## Configuration

The configuration file is located at `/usr/local/etc/buildkite/buildkite-agent.cfg`. See the [configuration documentation](/docs/agent/v3/configuration) for an explanation of each configuration setting.

## Upgrading

```
pkg upgrade buildkite-agent
```
