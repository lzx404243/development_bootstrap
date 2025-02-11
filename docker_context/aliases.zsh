# some more ls aliases
alias sl='ls'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

alias vim='nvim'
alias vimdiff='nvim -d'
alias view='nvim -R'

# Force tmux to advertise 256 colors. This makes the airline
# status line look nicer.
alias tmux='tmux -2'

alias gentags='ctags -R --c++-kinds=+p --fields=+iaS --extra=+q+f'
alias genptags='ctags -R --python-kinds=-i'

alias sbrc='source $HOME/.bashrc'
alias szrc='source $HOME/.zshrc'
alias pserver='python -m SimpleHTTPServer'
alias ptree='ps -aef --forest'
alias urldecode='python3 -c "import sys, urllib.parse as ul; \
    print(ul.unquote_plus(sys.argv[1]))"'
alias urlencode='python3 -c "import sys, urllib.parse as ul; \
    print (ul.quote_plus(sys.argv[1]))"'
