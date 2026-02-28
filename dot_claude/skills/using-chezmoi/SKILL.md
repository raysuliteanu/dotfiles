---
name: using-chezmoi
description: Use when managing dotfiles or system configuration with chezmoi — adding files, applying changes, syncing across machines, handling templates, or resolving conflicts.
---

# Using chezmoi

## Overview

`chezmoi` manages user configuration, system configuration and similar files
that you may want to keep in sync across multiple hosts. `chezmoi` uses `git` to
version control configuration, and distinguishes the configuration source
(usually cloned locally in ~/.local/share/chezmoi/) from the target, which is
the actual location of the files for the system (e.g.
~/.local/share/chezmoi/dot_config/ghostty/config vs ~/.config/ghostty/config).

## When to Use

Use `chezmoi` when:

- checking if a file is managed by `chezmoi`
- editing an existing user configuration file
- adding a new user configuration file
- having a config file that needs to be different for different operating
  systems or systems
- keeping configuration in sync across systems

Chezmoi can be used to sync more than configuration - any (typically text)
content that is useful across systems can be managed by chezmoi. For example,
shell scripts, such as those in ~/bin/ can be managed by chezmoi.

Do NOT use `chezmoi` when:

- editing system configuration e.g. in /etc

## Quick Reference

The full `chezmoi` command reference is: "<https://www.chezmoi.io/reference/>"

| Goal                                       | Command                   |
| ------------------------------------------ | ------------------------- |
| Edit a chezmoi-managed file                | `chezmoi edit ~/.zshrc`   |
| Add a file to chezmoi                      | `chezmoi add ~/.zshrc`    |
| Re-add a file to chezmoi modified manually | `chezmoi re-add ~/.zshrc` |
| Apply pending changes                      | `chezmoi apply`           |
| Check status                               | `chezmoi status`          |
| See what has changed in a file             | `chezmoi diff ~/.zshrc`   |
| Push pending changes                       | `chezmoi git push`        |
| Pull remote changes and apply              | `chezmoi update`          |

## Key Workflows

### Adding and Editing Files

If a file is not managed by chezmoi, it can be added with `chezmoi add`.

To determine if a file is managed by chezmoi, use `chezmoi unmanaged`. If the
file is not managed by chezmoi, then `chezmoi unmanaged` will echo the path of
the unmanaged file, otherwise it echos nothing (it does not use error codes).

If a file is managed by chezmoi and it needs modification, use `chezmoi edit`
which opens the chezmoi source file in $EDITOR (e.g. neovim) and on saving the
file automatically does a `chezmoi apply` to apply the changes to the target
file.

### Templates

Chezmoi supports templating configuration so that it can account for differences
in operating systems or hosts, or to ensure secrets are not committed to Git.
Templates support executing commands or scripts during conversion. Chezmoi
supports built-in commands for integrating with some systems like secrets
managers.

Templates are described in the chezmoi docs here: "<https://www.chezmoi.io/user-guide/templating/>"

An example of template usage is:

`export GITHUB_TOKEN={{ onepasswordRead "op://Personal/GitHub Personal Access Token/token" }}`

Note the use of `{{` and `}}`. Be careful NOT to remove the template indicators
if editing template files. This example shows using the chezmoi 1Password
integration for retrieving secrets.

### Syncing Across Machines

Use `chezmoi git` for interacting with the chezmoi Git repo e.g. `chezmoi git
log` or `chezmoi git push`. If `git.autoCommit = true` is set in the chezmoi
config, `chezmoi edit` will automatically stage and commit changes, so that you
can just do a `chezmoi git push`.

While you can do a diff with typical git diff
options via `chezmoi git diff` you can also see a diff with `chezmoi diff`
though with different command-line options than a full `git diff`.

To update a new system from the source state in a remote Git repo (e.g. it was
updated by another host doing a `chezmoi git push`), use the `chezmoi update`
command, which will by default pull from the remote and do a `chezmoi apply`
after the repo has been updated locally.

## Common Mistakes

- editing a file directly: if a chezmoi-managed file is edited directly, and not
  via `chezmoi edit` you can use the `chezmoi re-add` command.
