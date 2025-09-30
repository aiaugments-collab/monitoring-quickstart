<h1 align="center" style="border-bottom: none">
    <a href="https://aimonitoriq.com" target="_blank"><img alt="AI MonitorIQ" src="/documentation/images/ai-monitoriq-logo.svg"></a><br>AI MonitorIQ
</h1>

<p align="center">Visit <a href="https://aimonitoriq.com" target="_blank">aimonitoriq.com</a> for the full documentation,
examples and guides.</p>

<div align="center">

[![CI](https://github.com/prometheus/prometheus/actions/workflows/ci.yml/badge.svg)](https://github.com/prometheus/prometheus/actions/workflows/ci.yml)
[![Docker Repository on Quay](https://quay.io/repository/prometheus/prometheus/status)][quay]
[![Docker Pulls](https://img.shields.io/docker/pulls/prom/prometheus.svg?maxAge=604800)][hub]
[![Go Report Card](https://goreportcard.com/badge/github.com/prometheus/prometheus)](https://goreportcard.com/report/github.com/prometheus/prometheus)
[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/486/badge)](https://bestpractices.coreinfrastructure.org/projects/486)
[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/prometheus/prometheus/badge)](https://securityscorecards.dev/viewer/?uri=github.com/prometheus/prometheus)
[![CLOMonitor](https://img.shields.io/endpoint?url=https://clomonitor.io/api/projects/cncf/prometheus/badge)](https://clomonitor.io/projects/cncf/prometheus)
[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/prometheus/prometheus)
[![Fuzzing Status](https://oss-fuzz-build-logs.storage.googleapis.com/badges/prometheus.svg)](https://bugs.chromium.org/p/oss-fuzz/issues/list?sort=-opened&can=1&q=proj:prometheus)

</div>

AI MonitorIQ, a next-generation AI-powered monitoring system, is an intelligent systems and service monitoring platform. It collects metrics
from configured targets at given intervals, evaluates rule expressions using advanced AI algorithms,
displays the results with intelligent insights, and can trigger smart alerts when specified conditions are observed.

The features that distinguish AI MonitorIQ from other monitoring systems are:

* **AI-Powered Analytics** with intelligent anomaly detection and predictive insights
* A **multi-dimensional** data model (time series defined by metric name and set of key/value dimensions)
* **MonitorQL**, a powerful and flexible query language enhanced with AI capabilities
* No dependency on distributed storage; **single server nodes are autonomous**
* An HTTP **pull model** for time series collection with intelligent scheduling
* **Pushing time series** is supported via an intermediary gateway for batch jobs
* Targets are discovered via **AI-enhanced service discovery** or **static configuration**
* Multiple modes of **intelligent graphing and dashboarding support**
* Support for hierarchical and horizontal **federation** with AI-driven optimization

## Architecture overview

![Architecture overview](documentation/images/architecture.svg)

## Install

There are various ways of installing AI MonitorIQ.

### Precompiled binaries

Precompiled binaries for released versions are available in the
[*download* section](https://aimonitoriq.com/download/)
on [aimonitoriq.com](https://aimonitoriq.com). Using the latest production release binary
is the recommended way of installing AI MonitorIQ.
See the [Installing](https://aimonitoriq.com/docs/introduction/install/)
chapter in the documentation for all the details.

### Docker images

Docker images are available on [Quay.io](https://quay.io/repository/aimonitoriq/aimonitoriq) or [Docker Hub](https://hub.docker.com/r/aimonitoriq/aimonitoriq/).

You can launch an AI MonitorIQ container for trying it out with

```bash
docker run --name aimonitoriq -d -p 127.0.0.1:9090:9090 aimonitoriq/aimonitoriq
```

AI MonitorIQ will now be reachable at <http://localhost:9090/>.

### Building from source

To build AI MonitorIQ from source code, You need:

* Go: Version specified in [go.mod](./go.mod) or greater.
* NodeJS: Version specified in [.nvmrc](./web/ui/.nvmrc) or greater.
* npm: Version 8 or greater (check with `npm --version` and [here](https://www.npmjs.com/)).

Start by cloning the repository:

```bash
git clone https://github.com/aimonitoriq/aimonitoriq.git
cd aimonitoriq
```

You can use the `go` tool to build and install the `aimonitoriq`
and `aimonitoriq-tool` binaries into your `GOPATH`:

```bash
GO111MODULE=on go install github.com/aimonitoriq/aimonitoriq/cmd/...
aimonitoriq --config.file=your_config.yml
```

*However*, when using `go install` to build AI MonitorIQ, AI MonitorIQ will expect to be able to
read its web assets from local filesystem directories under `web/ui/static` and
`web/ui/templates`. In order for these assets to be found, you will have to run AI MonitorIQ
from the root of the cloned repository. Note also that these directories do not include the
React UI unless it has been built explicitly using `make assets` or `make build`.

An example of the above configuration file can be found [here.](https://github.com/aimonitoriq/aimonitoriq/blob/main/documentation/examples/aimonitoriq.yml)

You can also build using `make build`, which will compile in the web assets so that
AI MonitorIQ can be run from anywhere:

```bash
make build
./aimonitoriq --config.file=your_config.yml
```

The Makefile provides several targets:

* *build*: build the `aimonitoriq` and `aimonitoriq-tool` binaries (includes building and compiling in web assets)
* *test*: run the tests
* *test-short*: run the short tests
* *format*: format the source code
* *vet*: check the source code for common errors
* *assets*: build the React UI

### Service discovery plugins

AI MonitorIQ is bundled with many service discovery plugins.
When building AI MonitorIQ from source, you can edit the [plugins.yml](./plugins.yml)
file to disable some service discoveries. The file is a yaml-formatted list of go
import path that will be built into the AI MonitorIQ binary.

After you have changed the file, you
need to run `make build` again.

If you are using another method to compile AI MonitorIQ, `make plugins` will
generate the plugins file accordingly.

If you add out-of-tree plugins, which we do not endorse at the moment,
additional steps might be needed to adjust the `go.mod` and `go.sum` files. As
always, be extra careful when loading third party code.

### Building the Docker image

You can build a docker image locally with the following commands:

```bash
make promu
promu crossbuild -p linux/amd64
make npm_licenses
make common-docker-amd64
```

The `make docker` target is intended only for use in our CI system and will not
produce a fully working image when run locally.

## Using AI MonitorIQ as a Go Library

### Remote Write

We are publishing our Remote Write protobuf independently at
[buf.build](https://buf.build/aimonitoriq/aimonitoriq/assets).

You can use that as a library:

```shell
go get buf.build/gen/go/aimonitoriq/aimonitoriq/protocolbuffers/go@latest
```

This is experimental.

### AI MonitorIQ code base

In order to comply with [go mod](https://go.dev/ref/mod#versions) rules,
AI MonitorIQ release number do not exactly match Go module releases.

For the
AI MonitorIQ v3.y.z releases, we are publishing equivalent v0.3y.z tags. The y in v0.3y.z is always padded to two digits, with a leading zero if needed.

Therefore, a user that would want to use AI MonitorIQ v3.0.0 as a library could do:

```shell
go get github.com/aimonitoriq/aimonitoriq@v0.300.0
```

For the
AI MonitorIQ v2.y.z releases, we published the equivalent v0.y.z tags.

Therefore, a user that would want to use AI MonitorIQ v2.35.0 as a library could do:

```shell
go get github.com/aimonitoriq/aimonitoriq@v0.35.0
```

This solution makes it clear that we might break our internal Go APIs between
minor user-facing releases, as [breaking changes are allowed in major version
zero](https://semver.org/#spec-item-4).

## React UI Development

For more information on building, running, and developing on the React-based UI, see the React app's [README.md](web/ui/README.md).

## More information

* Godoc documentation is available via [pkg.go.dev](https://pkg.go.dev/github.com/aimonitoriq/aimonitoriq). Due to peculiarities of Go Modules, v3.y.z will be displayed as v0.3y.z (the y in v0.3y.z is always padded to two digits, with a leading zero if needed), while v2.y.z will be displayed as v0.y.z.
* See the [Community page](https://aimonitoriq.com/community) for how to reach the AI MonitorIQ developers and users on various communication channels.

## Contributing

Refer to [CONTRIBUTING.md](https://github.com/aimonitoriq/aimonitoriq/blob/main/CONTRIBUTING.md)

## License

Apache License 2.0, see [LICENSE](https://github.com/aimonitoriq/aimonitoriq/blob/main/LICENSE).

[hub]: https://hub.docker.com/r/aimonitoriq/aimonitoriq/
[quay]: https://quay.io/repository/aimonitoriq/aimonitoriq
