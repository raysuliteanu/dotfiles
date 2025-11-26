# General guidelines

## Tools

Use newer, more modern tools, replacing legacy tools, if available. For example,

- use fd rather than find
- use rg rather than grep
- use eza rather than ls

## Languages

### Scripting

Generally prefer shell scripts to other scripting languages like Python for
simple scripts. Propose using Python when the solution would be much simpler
or faster to execute.

- only use the github MCP server for interactions with github; avoid use the gh
  cli
