# General Guidelines

## Tools

Use newer, more modern tools, replacing legacy tools, if available. For example,

- use `fd` rather than `find`
- use `rg` rather than `grep`
- use `eza` rather than `ls`

## Docker

- use `docker compose` not `docker-compose`
- use the `dive` tool for checking generated images for optimal image generation

# Programming Guidelines

- in comments, focus on "why" over "what", avoiding obvious comments:
  - Simple utility functions where intent is clear from the signature
  - Trivial getters/setters or obvious wrapper code
  - Code that's primarily syntactic sugar over well-known patterns

# Testing Guidelines

Always create tests for new code, following the conventions of the programming
language in use.

Ensure all tests pass before offering to commit to source control.

When fixing bugs, first write a test or tests that reproduce the bug, then fix
the bug and ensure the test(s) now pass.

# Source Control

## General

Detect if the source control system for a project is `jj` by looking for a
`.jj/` directory, and then use `jj` commands for source control operations, even
if there's is also a `.git/` directory, since `jj` has a "co-located" mode for
better `git` interoperability. Only use `git` if there is only a `.git/`
directory without a `.jj/` directory.

Regardless of the actual source control tool (e.g. `git`, `jj`), follow the
[conventional commits](https://www.conventionalcommits.org/en/v1.0.0/)
guidelines defined.

When writing commit messages, explain any non-obvious trade-offs made in the
design or implementation.

Do not add `Co-Authored-By: Claude ...` tags.

## JJ

When doing commits, use `jj commit` and not `jj desc ... && jj new`.

## Git

Make sure you use `git mv` to move any files that are already checked into git.

# Programming Languages

## Rust

Use the `thiserror` crate for custom error types.

When adding dependencies to Rust projects, use `cargo add`.

In code that uses `color-eyre` or `anyhow` `Result`s, consistently use
`.context()` or `with_context()` prior to every error-propagation with `?`.
Context messages should be simple present tense, such as to complete the sentence
"while attempting to ...".

Prefer `expect()` over `unwrap()`. The `expect` message should be very
concise, and should explain why that expect call cannot fail.

When designing `pub` or crate-wide Rust APIs, consult the checklist in
<https://rust-lang.github.io/api-guidelines/checklist.html>.

`cargo fmt --check` runs automatically as a pre-push hook and `cargo clippy`
(with `-D warnings`) runs automatically after every `.rs` file save. Address
any issues they report before proceeding.

### Writing compile_fail Tests

Use `compile_fail` doctests to verify when certain code should _not_
compile, such as for type-state patterns or trait-based enforcement.
Each `compile_fail` test should target a specific error condition since
the doctest only has a binary output of whether it fails to compile, not
the many reasons _why_. Make sure you clearly explain exactly WHY the
code should fail to compile.

If there is no obvious item to add the doctest to, create a new private
item with `#[allow(dead_code)]` that you add the compile-fail tests to.
Document that that's its purpose.

## Java

Prefer `Gradle` (with `Groovy` syntax) over `Maven` for the build system for new
projects.

Prefer JDK LTS versions.

For backend services, use Spring Boot. When building containers for Java Spring
Boot projects, follow the recommendations and best practices for structuring the
image, using the Spring Boot Gradle/Maven plugins to build exploded JAR files.

### Exceptions

Prefer `RuntimeException` to `Exception` for APIs.

Create class hierarchies for business/domain exceptions that, generally, extend
`RuntimeException` and have a base exception class for all domain exceptions,

## General Scripting

Generally prefer shell scripts to other scripting languages like Python for
simple scripts. Propose using Python when the solution would be much simpler
or faster to execute.

For the shebang line, always use `#!/usr/bin/env` prefix to find the correct
shell binary, e.g. `#!/usr/bin/env bash`.

### Shell Scripts

Generally use `bash` as the shell script language.

`shellcheck` runs automatically as a post-save hook on `.sh` files. Address
any issues it reports before proceeding.
