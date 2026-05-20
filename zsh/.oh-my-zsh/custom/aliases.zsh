#!/usr/bin/env zsh

alias n="nvim .";

alias ga='git add -A'
alias gc='git commit -m'
alias gcm='git commit -m'
alias meow='git commit -m "meow"'
alias rew='git add -A && git commit -m "review" && git push'
alias gca='git commit --amend'
alias gp='git push'
alias gpf='git push --force'
alias gu='git pull'
alias gmm='git merge master'
alias gs='git status'
alias gd='git diff'
alias gds='git diff --staged'
alias gdss='git diff --staged --stat'
alias gdms='git diff master --stat'
alias gsc='git switch -c'
alias gsm='git switch master'
alias gr='git restore .'
alias grs='git restore --staged .'

alias gbl='git blame -w'
alias gb='git bisect start'
alias gbew='git bisect start && git bisect bad && git bisect good $(git rev-list --max-parents=0 --first-parent HEAD)'
alias gbb='git bisect bad'
alias gbg='git bisect good'
alias gbn='git bisect new'
alias gbo='git bisect old'
alias gbend='git bisect reset'

alias gur='git pull --rebase'
alias grc='git rebase --continue'

alias gccc='go mod tidy && go clean -cache -modcache'
alias gg='go get'
alias gmt='go mod tidy'
alias gmv='go mod vendor'

alias t="tmux";
alias ta="tmux a";

alias mg="make generate";
alias mm="make mocks";
alias mgm="make generate-mocks";

alias dsaa="docker stop \$(docker ps -a -q)"
alias draa="docker rm \$(docker ps -a -q)"
alias dsa="docker stop \$(docker ps -q | xargs -I {} sh -c 'docker inspect --format \"{{.Config.Image}}\" {} 2>/dev/null | grep -q \"claude\" || echo {}')"
alias dra="docker rm -f \$(docker ps -a -q | xargs -I {} sh -c 'docker inspect --format \"{{.Config.Image}}\" {} 2>/dev/null | grep -q \"claude\" || echo {}')"

alias alert="print '\a'"

alias tu='gotestsum -- -fullpath ./... || true && printf "\a"';
alias tuc='gotestsum -- -coverprofile=coverage.out -fullpath ./... || true && printf "\a"';

alias gur='git pull --rebase';
alias grc='git rebase --continue'
#alias gpro="git pull --rebase origin master"; # ????
alias gccc="go mod tidy && go clean -cache -modcache";
