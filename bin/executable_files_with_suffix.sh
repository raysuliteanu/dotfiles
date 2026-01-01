#!/usr/bin/env bash

# print the count of different file types by file extension in the current
# directory tree, sorted by high count to low count.
#
# Prerequisite: `fd` command

fd -t f -E .git -E node_modules -E build |
    awk -F. '{if (NF>1) print $NF}' |
    sort | uniq -c |
    awk '{print $2, $1}' |
    sort -k2 -rn
