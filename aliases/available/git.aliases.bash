#!/bin/bash

# Aliases
alias gcl='git clone'
alias ga='git add'
alias gall='git add .'
alias g='git'
alias get='git'
alias gst='git status'
alias gs='git status'
alias gss='git status -s'
alias gl='git pull'
alias gp='git push'
alias gpo='git push origin'
alias gph='git push heroku master'
alias gdv='git diff -w "$@" | vim -R -'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gce='git commit --allow-empty-message -m ""'
alias gcb='git add . && git commit --allow-empty-message -m ""'
alias gci='git commit --interactive'
alias gb='git branch'
alias gba='git branch -a'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias gco='git checkout'
alias gexport='git archive --format zip --output'
alias gdel='git branch -d'
alias gmu='git fetch origin -v; git fetch upstream -v; git merge upstream/master'
alias gll='git log --graph --pretty=oneline --abbrev-commit'

## https://gist.github.com/590895
## via http://notes.envato.com/developers/rebasing-merge-commits-in-git/
function git_current_branch() {
  git symbolic-ref HEAD 2> /dev/null | sed -e 's/refs\/heads\///'
}

alias grb='git rebase -p'
alias gup='git fetch origin && grb origin/$(git_current_branch)'
alias gpthis='git push origin HEAD:$(git_current_branch)'
alias gm='git merge --no-ff'
alias gsync='git fetch origin && git rebase -p origin/$(git_current_branch) && git push origin HEAD:$(git_current_branch)'

case $OSTYPE in
  linux*)
    alias gd='git diff | vim -R -'
    ;;
  darwin*)
    alias gd='git diff | vim -R -'
    ;;
  darwin*)
    alias gd='git diff'
    ;;
esac



function git-help() {
  echo "Git Custom Aliases Usage"
  echo
  echo "  gcl	  = git clone"
  echo "  g       = git"
  echo "  get 	  = git"
  echo "  ga      = git add"
  echo "  gall	  = git add ."
  echo "  gst/gs  = git status"
  echo "  gss	  = git status -s"
  echo "  gl      = git pull"
  echo "  gp      = git push"
  echo "  gd      = git diff | vim -R -"
  echo "  gdv     = git diff -w \"$@\" | vim -R -"
  echo "  gc      = git commit -v"
  echo "  gce     = git commit --allow-empty-message -m ''"
  echo "  gcb     = git add . && git commit --allow-empty-message -m ''"
  echo "  gca     = git commit -v -a"
  echo "  gci 	  = git commit --interactive"
  echo "  gb      = git branch"
  echo "  gba     = git branch -a"
  echo "  gcount  = git shortlog -sn"
  echo "  gcp     = git cherry-pick"
  echo "  gco     = git checkout"
  echo "  gexport = git git archive --format zip --output"
  echo "  gdel    = git branch -d"
  echo "  gpo     = git push origin"
  echo "  gph     = git push heroku master"
  echo "  gmu     = git fetch origin -v; git fetch upstream -v; git merge upstream/master"
  echo "  gll     = git log --graph --pretty=oneline --abbrev-commit"
  echo "  grb     = git rebase -p"
  echo "  gup     = git fetch origin && grb origin/<git_current_branch>"
  echo "  gpthis  = git push origin HEAD:<git_current_branch>"
  echo "  gm      = git merge --no-ff"
  echo "  gsync   = gup && gpthis"
  echo
}
