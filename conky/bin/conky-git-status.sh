#!/bin/bash

GIT_STATUS_ENV=~/.conky/git-status-env.sh

gitbranch() {
  git branch | pcregrep -o1 '^\*\s*(.*)'
}

summarize() {
  local repo branch status

  repo="$1"
  cd "${repo}" || exit 1

  branch=$(git branch -vv \
          | grep -o '\[[^]]*: [^]]*\]' \
          | sed 's/^\[\([a-zA-Z0-9_-]\+\)/  \${color 6897ee}\1\${color}/;s/\]//')
  status=$(git status -s)
  if [ -n "${branch}" ] || [ -n "${status}" ]; then
    repo="${repo#$DEV_HOME/}"
    repo="${repo#$HOME/}"
    echo "\${color white}$repo\${color}"
  fi

  if [ -n "${branch}" ]; then
    echo "${branch}"
  fi

  if [ -n "${status}" ]; then
    symbols="$(echo "${status}" | sed 's/^ *//' | cut -d' ' -f1)"
    unique_symbols="$(echo "${symbols}" | sort -u)"
    while read -r unique_symbol; do
      symbol_count="$(echo "${symbols}" | grep -c "^${unique_symbol}")"
      echo "  \${color #5F9EA0}${unique_symbol}\${color}: ${symbol_count} files"
    done <<<"${unique_symbols}"
  fi

  if [ -n "${branch}" ] || [ -n "${status}" ]; then
    echo
  fi
}

main() {
  local repo all n_lines screen_height top_padding conky_line_size

  screen_height=$(xdpyinfo | grep 'dimensions:' | awk '{print $2}' | cut -dx -f2)
  top_padding=45
  conky_line_size=8

  all="$(. conky-status-all.sh)"
  n_lines="$(echo "${all}" | wc -l)"

  if [ $(( n_lines * conky_line_size )) -gt $(( screen_height - top_padding )) ]; then
    for repo in "${MY_GIT_REPOSITORIES_LIST[@]}"; do
      ( summarize "${repo}" )
    done
  else
    echo "${all}"
  fi
}

[ -f $GIT_STATUS_ENV ] && . ~/.conky/git-status-env.sh
main "$@"
