# Global Instructions

These are personal, cross-project defaults. Prefer project-local `AGENTS.md`,
repository docs, and existing code conventions when they conflict with anything
here.

## Working Style

- Keep changes minimal and targeted. Prefer the smallest correct diff over broad
  refactors.
- Preserve the repository's existing style, structure, naming, and architecture
  unless there is a clear reason to change them.
- For complex features or risky refactors, make a plan before editing.
- Do not invent project facts. Read the relevant code and docs first.
- Avoid adding new abstractions, files, or helpers unless they materially
  improve the result.
- Put knowledge in the right place. Prefer existing docs and code comments over
  creating new top-level files.

## Safety

- Never use destructive commands like `rm -rf`, hard resets, or force pushes
  unless explicitly requested.
- Do not revert or overwrite changes you did not make unless explicitly asked.
- Never hardcode secrets, tokens, or credentials.
- Validate external input at system boundaries and fail clearly.
- Do not leak sensitive information in logs, error messages, or commits.

## Verification

- Add tests for new code when the repository has an appropriate test suite.
- For bug fixes, prefer writing or updating a test that reproduces the issue
  before fixing it.
- Run the smallest relevant verification for the change first, then broader
  checks if needed.
- Ensure tests and linters pass before offering to commit when they are
  practical to run locally.
- Do not claim code is working without verification when verification is
  available.

## Source Control

- If a project has a `.jj/` directory, use `jj` for source control operations.
  Otherwise use `git`.
- Follow conventional commits when writing commit messages.
- Explain non-obvious trade-offs in commit messages when appropriate.
- Do not add AI co-author trailers.
- Use `git mv` for tracked file moves.
- With `jj`, use `jj commit` rather than `jj desc ... && jj new`.

## Tool Preferences

- Prefer modern tools when available: `rg` over `grep`, `fd` over `find`, `eza`
  over `ls`.
- For Docker, prefer `docker compose` over `docker-compose`.
- Use comments sparingly and focus them on why, not what.

## Language Preferences

### Rust

- Use `thiserror` for custom error types.
- Use `cargo add` when adding dependencies.
- In code using `anyhow` or `color-eyre`, add `.context()` or `with_context()`
  before propagating errors with `?`.
- Prefer `expect()` over `unwrap()`, with a concise message explaining why
  failure is impossible.
- For Axum route params, use `{param}` syntax, not `:param`.
- Address `cargo fmt`, `clippy`, and other reported issues before finishing Rust
  changes when those checks are part of the repo workflow.

### Java

- Prefer Gradle with Groovy syntax over Maven for new projects.
- Prefer JDK LTS releases.
- For backend services, prefer Spring Boot unless the project already uses
  something else.
- Prefer `RuntimeException` over checked `Exception` types for API-facing domain
  errors.

### Shell

- Prefer shell scripts for simple scripting tasks; use Python when it clearly
  simplifies the solution.
- Use `#!/usr/bin/env bash` for bash scripts.
- Address `shellcheck` findings when working on shell scripts.
