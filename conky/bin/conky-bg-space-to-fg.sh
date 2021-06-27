#!/usr/bin/env bash

esc="$(echo -ne "\033")"
sp="$(printf "\xE2\x96\x88")"

sed -r "s/\[48([^ ${esc}]+) /[38\1${sp}/g;: loop s/${sp} /${sp}${sp}/; t loop"
