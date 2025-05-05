# some functions to combined brew with fzf

# mnemonic [B]rew [I]nstall [P]ackage
bip() {
  local inst=$(brew search "$@" | fzf --layout=reverse-list --preview='brew info {}')

  if [[ $inst ]]; then
    for prog in $(echo $inst);
    do; brew install $prog; done;
  fi
}

# mnemonic [B]rew [U]pdate [P]ackage
bup() {
  local upd=$(brew leaves | fzf --layout=reverse-list --preview='brew info {}')

  if [[ $upd ]]; then
    for prog in $(echo $upd);
    do; brew upgrade $prog; done;
  fi
}

# mnemonic [B]rew [R]emove [P]ackage (e.g. uninstall)
brp() {
  local uninst=$(brew leaves | fzf --layout=reverse-list --preview='brew info {}')

  if [[ $uninst ]]; then
    for prog in $(echo $uninst);
    do; brew uninstall $prog; done;
  fi
}

