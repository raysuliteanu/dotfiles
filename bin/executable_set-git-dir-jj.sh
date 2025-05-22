# if in a jj repo, git commands don't work even though currently git is
# the default store in jj. If for some reason you want to look at the git
# stuff with git commands, set GIT_DIR ...
GIT_DIR=$(jj git root)
export GIT_DIR
