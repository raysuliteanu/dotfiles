alias a=alias

a claude="/home/ray/.claude/local/claude"

a tmuxconfig="chezmoi edit --apply ~/.config/tmux/tmux.conf"
a zshconfig="chezmoi edit --apply ~/.zshrc"
a zalias="chezmoi edit --apply ~/.oh-my-zsh/custom/aliases.zsh"
a nvimconfig="chezmoi edit --apply ~/.config/nvim"

a cm=chezmoi
a ce="cm edit --apply"
a cs="cm status"
a ca="cm apply"
a cpush="cm git push"

# a vi=~/nvim-linux-x86_64/bin/nvim
a vi=hx-latest
a vim=hx-latest
a v=hx-latest
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
a top=bpytop
a cat=bat
a curl=curlie
a e=emacs
a du=dust
a fd='fd -H'
a cd=z
a lg=lazygit
a rg='rg -i'

a dps='docker ps'
a ds='docker search'
a docker-use-context='docker context use $(docker context ls -q | fzf --height=10 --prompt="use context > ")'

a ls='eza --icons --git --git-ignore'
a l='ls -l'
a ll='ls -l'
a la='ls -la'
a lR='ls -lR'
# when using exa to sort by timestamp it's '-sold' not '-t'
a lrt='ls -lr -sold'
a lart='ls -lar -sold'

a warp='warp-terminal > /dev/null 2>&1 &'

a kscope='cscope -kd -p 3'

a wezterm='open-wezterm-here &'

a obs="fd -E .git -e .md --base-directory ~/Documents/Obsidian/Ray . | fzf --preview 'cat ~/Documents/Obsidian/Ray/{}' --bind 'enter:become(nvim '~/Documents/Obsidian/Ray/{}')'"

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

