Example usage:

# Interactive mode - confirm each repo

./make-shallow-repo.sh /home/src/ghostty /home/src/foo

# Force mode - confirm once for all

./make-shallow-repo.sh --force /home/src/ghostty /home/src/foo

# Combined with find script

./make-shallow-repo.sh $(./find-shallow-repos.sh --print-non-shallow ~/src)
