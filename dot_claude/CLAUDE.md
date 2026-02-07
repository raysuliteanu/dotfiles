# General Guidelines

## Tools

Use newer, more modern tools, replacing legacy tools, if available. For example,

- use `fd` rather than `find`
- use `rg` rather than `grep`
- use `eza` rather than `ls`

Be aware of shell aliases that could cause issues, such as

- `cd` is aliased to `z` for `zoxide`; this causes issues with changing directories
since `z` is a shell function but it is not sourced in the environment claude runs
in, so `cd` fails.
- `cat` is aliases to `bat`; this may cause issues since there is paging by default
and so it will sometimes be that the `cat` command appears not to exit since it's
waiting for input.

## Docker

- use `docker compose` not `docker-compose`
- use the `dive` tool for checking generated images for optimal image generation

# Programming Guidelines

If practical, prefer self-contained projects, minimizing external dependencies
when simple/straightforward.

Apply 'clean code' guidelines generally:

- use descriptive names for types, methods, fields, variables, etc.; however,
  follow the standards and conventions of the programming language in use.
- code should "flow" like a top-down "story" with methods defined later in a
  file than the methods that call them e.g.

```rust
fn main() {
    foo();
    bar();
}

fn foo() {
    baz();
}

fn bar() {
}

fn baz() {
}
```

- in comments, focus on "why" over "what", avoiding obvious comments:
  - Simple utility functions where intent is clear from the signature
  - Trivial getters/setters or obvious wrapper code
  - Code that's primarily syntactic sugar over well-known patterns

## Testing Guidelines

Follow [these](https://kidoni.dev/there-is-no-such-thing-as-regression-testing)
guidelines for what different classes of tests are (unit vs integration vs system).

Always create unit tests for new code, following the conventions of the
programming language in use.

Ensure all tests pass before offering to commit to source control.

## Source Control

### General

Regardless of the actual source control tool (e.g. `git`, `jj`), follow the
[conventional commits](https://www.conventionalcommits.org/en/v1.0.0/)
guidelines defined.

When writing commit messages, ensure that you explain any
non-obvious trade-offs made in the design or implementation.

When you refer to types or very short code snippets, place them in
backticks. When you have a full line of code or more than one line of
code, put them in indented code blocks.

Prefer to write commit messages by using a temporary file rather
than using command-line arguments. Remove the temporary file afterwards.

### Git

Make sure you use git mv to move any files that are already checked into
git.

## Languages

### Rust

Use the `thiserror` crate for custom error types.

When adding dependencies to Rust projects, use `cargo add`.

In code that uses `color-eyre` or `anyhow` `Result`s, consistently use
`.context()` prior to every error-propagation with `?`. Context
messages in `.context` should be simple present tense, such as to
complete the sentence "while attempting to ...".

Prefer `expect()` over `unwrap()`. The `expect` message should be very
concise, and should explain why that expect call cannot fail.

When designing `pub` or crate-wide Rust APIs, consult the checklist in
<https://rust-lang.github.io/api-guidelines/checklist.html>.

Always run `cargo clippy` after code changes and address issues reported.

Run `cargo fmt --check` before committing to source control, and if there is a
formatting issue, run `cargo fmt` to fix the formatting.

#### Writing compile_fail Tests

Use `compile_fail` doctests to verify when certain code should _not_
compile, such as for type-state patterns or trait-based enforcement.
Each `compile_fail` test should target a specific error condition since
the doctest only has a binary output of whether it fails to compile, not
the many reasons _why_. Make sure you clearly explain exactly WHY the
code should fail to compile.

If there is no obvious item to add the doctest to, create a new private
item with `#[allow(dead_code)]` that you add the compile-fail tests to.
Document that that's its purpose.

### Java

Prefer `Gradle` (with `Groovy` syntax) over `Maven` for the build system.

Prefer JDK LTS versions.

For backend services, use Spring Boot. When building containers for Java Spring
Boot projects, follow the recommendations and best practices for structuring the
image, using the Spring Boot Gradle/Maven plugins to build exploded JAR files.

#### Exceptions

Prefer `RuntimeException` to `Exception` for APIs.

Create class hierarchies for business/domain exceptions that, generally, extend
`RuntimeException` and have a base exception class for all domain exceptions,
and override all constructors. For example,

```java
public abstract class MyBaseDomainException extends RuntimeException {
    // ...
}
public class MyMessagingDomainException extends MyBaseDomainException {
    // ...
}
public class MySpecificMessagingDomainException extends MyMessagingDomainException {
    // ...
}
public class MyDatabaseDomainException extends MyBaseDomainException {
    // ...
}
```

### General Scripting

Generally prefer shell scripts to other scripting languages like Python for
simple scripts. Propose using Python when the solution would be much simpler
or faster to execute.

For the shebang line, always use `#!/usr/bin/env` prefix to find the correct
shell binary, e.g. `#!/usr/bin/env bash`.

#### Shell Scripts

Generally use `bash` as the shell script language.

Run shell scripts through `shellcheck`.

## SESSION.md

While working, if you come across any bugs, missing features, or other
oddities about the implementation, structure, or workflow, **add a
concise description of them to SESSION.md** to defer solving such
incidental tasks until later. You do not need to fix them all straight
away unless they block your progress; writing them down is often
sufficient. **Do not write your accomplishments into this file.**

## Common failure modes when helping

### The XY Problem

The XY problem occurs when someone asks about their attempted solution (Y)
instead of their actual underlying problem (X).

#### The Pattern

1. User wants to accomplish goal X
2. User thinks Y is the best approach to solve X
3. User asks specifically about Y, not X
4. Helper becomes confused by the odd/narrow request
5. Time is wasted on suboptimal solutions

#### Warning Signs to Watch For

- Focus on a specific technical method without explaining why
- Resistance to providing broader context when asked
- Rejecting alternative approaches outright
- Questions that seem oddly narrow or convoluted
- "How do I get the last 3 characters of a filename?" (when they want file extension)

#### How to Avoid It (As Helper)

- **Ask probing questions**: "What are you trying to accomplish overall?"
- **Request context**: "Can you explain the bigger picture?"
- **Challenge assumptions**: "Why do you think this approach will work?"
- **Offer alternatives**: "Have you considered...?"

#### Red Flags in User Requests

- Very specific technical questions without motivation
- Unusual or roundabout approaches to common problems
- Dismissal of "why do you want to do that?" questions
- Focus on implementation details before problem definition

#### Key Principle

Always try to understand the fundamental problem (X) before helping with the
proposed solution (Y). The user's approach may not be optimal or may indicate
they're solving the wrong problem entirely.
