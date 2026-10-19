# AI Agents Guide (`AGENTS.md`)

## Folder

`/lib/libs/shake`

## SRP

Owns reusable device shake detection. The detector observes lifecycle and sensor events and emits a callback; the consumer owns the application's response.

## Forbidden

- application routing, logging, toast, or diagnostic-response policy inside the detector
