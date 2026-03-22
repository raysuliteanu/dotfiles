# nvim
alias vi nvim
alias vim vi
alias v vi
alias view 'vi -R'
alias sudovi 'sudo (which nvim)'

# chezmoi
alias cm chezmoi
alias cme 'cm edit --apply'
alias cms 'cm status'
alias cma 'cm apply'
alias cmpush 'cm git push'

# config shortcuts
alias tmuxconfig 'chezmoi edit --apply ~/.config/tmux/tmux.conf'
alias zshconfig 'chezmoi edit --apply ~/.zshrc'
alias zalias 'chezmoi edit --apply ~/.oh-my-zsh/custom/aliases.zsh'
alias fishconfig 'chezmoi edit --apply ~/.config/fish/config.fish'
alias fishalias 'chezmoi edit --apply ~/.config/fish/conf.d/aliases.fish'
alias nvimconfig 'chezmoi edit --apply ~/.config/nvim'

# brew
alias b brew
alias bs 'brew search'
alias bi 'brew info'
alias bl 'brew list'
alias bu 'brew update'
alias bcl 'brew cleanup'
alias bo 'brew outdated'
alias ba 'brew autoremove'
alias bsl 'brew services list'
alias bsoff 'brew services stop'
alias bson 'brew services start'
alias bsr 'brew services run'

# shell
alias h history
alias c clear
alias more 'less -F'
alias less 'less -F'
alias top bpytop
alias cat bat
alias curl curlie
alias e emacs
alias du dust
alias fd 'fd -H'
alias fdni 'fd --no-ignore -H'
alias lg lazygit
alias rg 'rg -i'
alias mutt neomutt
alias tf 'tail -f'
alias python python3
alias glow 'glow -t'

# ls (eza)
alias ls 'eza --icons --git'
alias l 'ls -l'
alias ll 'ls -l'
alias lL 'ls -lX'
alias la 'ls -a'
alias lR 'ls -lR'
alias lrt 'ls -l -snew'
alias lart 'ls -la -snew'

# docker
alias dps 'docker ps'
alias ds 'docker search'
alias docker-use-context 'docker context use (docker context ls -q | fzf --height=10 --prompt="use context > ")'

# git
alias gpff 'git pull -ff'
alias gst 'git status'
alias gd 'git diff'
alias glog 'git log --oneline --graph'

# taskwarrior
alias t task
alias ta 'task add'
alias ts 'task start'
alias tst 'task stop'
alias td 'task done'
alias tan 'task ann'
alias tc 'task calendar'
alias tctx 'task context'
alias to taskopen

# codecrafters
alias ccs 'codecrafters submit'
alias cct 'codecrafters test'
alias cctp 'codecrafters test --previous'

# c-scope
alias kscope 'cscope -kd -p 3'

# terminals
alias warp 'warp-terminal > /dev/null 2>&1 &'
alias wezterm 'open-wezterm-here &'

# Obsidian fuzzy open (bat used directly since fzf preview runs in bash, not fish)
alias obs "fd -E .git -e .md --base-directory ~/Documents/Obsidian/Ray . | fzf --preview 'bat --color=always ~/Documents/Obsidian/Ray/{}' --bind 'enter:become(nvim ~/Documents/Obsidian/Ray/{})'"

# NOTE: zsh suffix aliases (-s md=glow, -s rs=$EDITOR, etc.) have no fish equivalent.
# To open files by extension, use the full command: e.g. `glow README.md`
