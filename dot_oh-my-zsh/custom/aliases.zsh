alias a=alias

# use nvim with sudo
a sudovi='sudo $(which nvim)'

a tmuxconfig="chezmoi edit --apply ~/.config/tmux/tmux.conf"
a zshconfig="chezmoi edit --apply ~/.zshrc"
a zalias="chezmoi edit --apply ~/.oh-my-zsh/custom/aliases.zsh"
a nvimconfig="chezmoi edit --apply ~/.config/nvim"

a cm=chezmoi
a cme="cm edit --apply"
a cms="cm status"
a cma="cm apply"
a cmpush="cm git push"

a vi=nvim
a vim=vi
a v=vi
a view='vi -R'

a b=brew
a bs='brew search'
a bi='brew info'
a bl='brew list'
a bu='brew update'
a bcl='brew cleanup'
a bo='brew outdated'
a ba='brew autoremove'
a bsl='brew services list'
a bsoff='brew services stop'
a bson='brew services start'
a bsr='brew services run'

a h=history
a c=clear
a more='less -F'
a less='less -F'
#a top='btm --color=nord-light'
a top=btop
a cat=bat
a curl=curlie
a e=emacs
a du=dust
a fd='fd -H'
a fdni='fd --no-ignore -H'
a cd=z
a lg=lazygit
a lj=lazyjj
a rg='rg -i'

a dps='docker ps'
a ds='docker search'
a docker-use-context='docker context use $(docker context ls -q | fzf --height=10 --prompt="use context > ")'

a k=kubectl

a ls='eza --icons --git'
a l='ls -l'
a ll='ls -l'
a lL='ls -lX' # eza -X == ls -L
a la='ls -a'
a lR='ls -lR'
# eza -snew == ls -rt
a lrt='ls -l -snew'
a lart='ls -la -snew'

a warp='warp-terminal > /dev/null 2>&1 &'

a kscope='cscope -kd -p 3'

a wezterm='open-wezterm-here &'

a obs="fd -E .git -e .md --base-directory ~/Documents/Obsidian/Ray . | fzf --preview 'bat ~/Documents/Obsidian/Ray/{}' --bind 'enter:become(nvim '~/Documents/Obsidian/Ray/{}')'"

# taskwarrior
a t=task
a ta='task add'
a ts='task start'
a tst='task stop'
a td='task done'
a tan='task ann'
a tc='task calendar'
a tctx='task context'
a to=taskopen

# codecrafters
a ccs='codecrafters submit'
a cct='codecrafters test'
a cctp='codecrafters test --previous'

a python=python3

a gpff='git pull -ff'
a gst='git status'
a gd='git diff'
a glog='git log --oneline --graph'

a tf='tail -f'

a glow='glow -t'

# suffix aliases
# run `glow` if file on command-line ends in '.md' without command first
# i.e. "$ README.md" --> "$ glow README.md"
a -s md=glow
# run `open` for jpg|gif|svg
a -s jpg=open
a -s gif=open
a -s svg=open
a -s rs=$EDITOR
a -s java=$EDITOR
a -s c=$EDITOR
a -s C=$EDITOR
a -s h=$EDITOR
a -s S=$EDITOR
a -s s=$EDITOR
a -s cpp=$EDITOR
a -s ts=$EDITOR
a -s tsx=$EDITOR
a -s js=$EDITOR
a -s jsx=$EDITOR
a -s css=$EDITOR

a mutt=neomutt

a tm='sesh connect $(sesh list | fzf)'

a ts=tailscale
