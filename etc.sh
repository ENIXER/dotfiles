#!/bin/zsh

function mkcd () {
  mkdir $1 && cd $_
}

function daily_report () {
  today=`date "+%Y/%m/%d"`
  report_path="$HOME/esa/daily_report/${today}"
  mkdir -p $report_path
  pushd $report_path
  if [ -f 'text.md' ]; then
  else
  cat <<CONTENTS > text.md
日報 ${today}
===

やったこと
---

考えたこと
---

気分
---

明日やること
---

CONTENTS
  fi
  vim text.md
  popd
}

function update () {
  pushd ~/dotfiles
  git pull origin master
  popd
  pushd ~/.enhancd
  git pull origin master
  popd
  source ~/.zshrc
  brew update
  brew upgrade
  brew cask upgrade
  brew cleanup
  asdf plugin-update --all
}

function memop () {
  mkdir -p ~/Documents/memo
  today=`date "+%Y%m%d"`
  vim "$HOME/Documents/memo/${today}.md"
}

function gcd() {
  if [ $# -eq 1 ]; then
    repo=$(ghq list -p | fzf -q $1)
  else
    repo=$(ghq list -p | fzf)
  fi

  if [ -n "$repo" ]; then
    cd $repo
  fi
}
