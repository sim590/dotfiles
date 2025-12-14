
def nufzf [] {
  $in | each { |i| $i | to json --raw }
      | str join "\n"
      | fzf -m
      | lines
      | each { $in | from json }
      | reduce { |it, acc| $acc | append $it }
}

