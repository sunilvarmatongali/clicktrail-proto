# clicktrail-proto

The shared **gRPC contract** of the ClickTrail platform.
It holds the `.proto` files and the generated Go code, published as a versioned Go module.

| Item | Value |
|---|---|
| Go module | `github.com/sunilvarmatongali/clicktrail-proto` |
| Import path | `github.com/sunilvarmatongali/clicktrail-proto/gen/clicktrail/analytics/v1` |
| Used by | `clicktrail-gateway` (client), `clicktrail-analytics-service` (server) |

## Why a separate repository?

The gateway and the analytics service must agree on the same contract. If each kept its
own copy, they could drift apart. Here the contract has one owner and one version number.
A service upgrades by running `go get github.com/sunilvarmatongali/clicktrail-proto@vX.Y.Z`.

## Layout

```
proto/clicktrail/analytics/v1/analytics.proto   the contract (edit this)
gen/clicktrail/analytics/v1/                    generated Go code (never edit by hand)
buf.yaml / buf.gen.yaml                         lint rules and code-generation settings
```

## Rules for changing the contract

- Adding a new field or RPC is safe. Removing or renumbering a field is a breaking change.
- `buf lint` enforces naming style in CI.
- After every change: `make generate`, commit the generated code with the `.proto`, update
  `CHANGELOG.md`, then tag a release.

## Commands

You need Go, [`buf`](https://buf.build/docs/installation), `protoc-gen-go` and `protoc-gen-go-grpc`.

```bash
make lint       # style check on the .proto files
make generate   # regenerate Go code
make verify     # lint + generate + build + check nothing is out of date
```

## Releasing

```bash
git tag v0.1.0
git push origin v0.1.0
```
