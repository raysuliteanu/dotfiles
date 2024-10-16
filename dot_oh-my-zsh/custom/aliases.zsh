alias a=alias

a tmuxconfig="chezmoi edit --apply ~/.config/tmux/tmux.conf"
a zshconfig="chezmoi edit --apply ~/.zshrc"
a zalias="chezmoi edit --apply ~/.oh-my-zsh/custom/aliases.zsh"
a nvimconfig="echo $(fd --glob '*.lua' ~/.config/nvim | tr '\n' ' ') | xargs chezmoi edit --apply"
a ce="chezmoi edit --apply"
a cs="chezmoi status"
a ca="chezmoi apply"
a cpush="chezmoi git push"

a vi=nvim
a vim=nvim
a v=nvim

a b=brew
a bs='b search'
a bi='b info'
a bl='b list'
a bu='b update'
a bcl='b cleanup'
a bo='b outdated'
a ba='brew autoremove'
a bsl='brew services list'
a bsoff='brew services stop'
a bson='brew services start'
a bsr='brew services run'
a bup='brew upgrade'

a h=history
a c=clear
a more='less -F'
a less='less -F'
#a top='btm --color=nord-light'
a top=bpytop
a cat='bat --theme=ansi'
a curl=curlie
a e=emacs
a du=dust
a fd='fd -H'
a cd=z
a t=tmux
a lg=lazygit

a dps='docker ps'

a ls='eza --git'
a l='ls -l'
a ll='ls -l'
a la='ll -a'
a lR='ls -R'
# when using exa to sort by timestamp it's '-snew' not '-t'
a lrt='ls -lr -snew'
a lart='ls -lar -snew'

a warp='warp-terminal > /dev/null 2>&1 &'

a kscope='cscope -kd -p 3'

a wezterm='open-wezterm-here &'

a obs="fd -E .git -e .md --base-directory ~/Documents/Obsidian/Ray . | fzf --preview 'cat ~/Documents/Obsidian/Ray/{}' --bind 'enter:become(nvim '~/Documents/Obsidian/Ray/{}')'"
