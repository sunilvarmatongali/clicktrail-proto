# ADR 0001: Use gRPC between the gateway and the analytics service

- Status: Accepted
- Date: 2026-10-11

## Context

The gateway needs click statistics from the analytics service. Both are internal, so the
call does not have to be public REST. We want a strict contract, small payloads and
generated client/server code.

## Decision

Use gRPC with Protocol Buffers. The contract lives in this repository so both sides depend on
one versioned source.

## Consequences

- Positive: compile-time checked contract, generated code, efficient binary format.
- Positive: one place to review every API change between the two services.
- Negative: the team must learn protobuf tooling (`buf`), and the contract needs versioning discipline.
- Alternative considered: internal REST/JSON. Simpler to debug, but no enforced contract.
