
$env.FZF_COMPLETERS = {
  pacman: {|prefix, spans|
    let sub = $spans | skip 1 | first
    if ($sub =~ "-[SF]") {
        {
          candidates: (^pacman -Slq | lines),
          opts:       ["-m", "--preview", "pacman -Si {}", "--prompt", "Paquet > "]
        }
    } else if ($sub =~ "-[QR]") {
        {
          candidates: (^pacman -Qq | lines),
          opts:       ["-m", "--preview", "pacman -Qi {}", "--prompt", "Paquet > "]
        }
    } else if ($sub =~ "-U") {
        let root = $prefix | str trim --right --char '/' | path expand
        {
          candidates: (glob $"($root)/**/*.pkg.tar.zst"),
          opts:       ["-m", "--query", "", "--preview", "pacman -Qp {} 2>/dev/null", "--prompt", "Fichier > "]
        }
    } else {
        { candidates: [], opts: [] }
    }
  }
  yay: {|prefix, spans|
    let sub = $spans | skip 1 | first
    if ($sub =~ "-[SF]") {
        {
          candidates: (^yay -Slq | lines),
          opts:       ["-m", "--preview", "yay -Si {}", "--prompt", "Paquet > "]
        }
    } else if ($sub =~ "-[QR]") {
        {
          candidates: (^yay -Qq | lines),
          opts:       ["-m", "--preview", "yay -Qi {}", "--prompt", "Paquet > "]
        }
    } else {
        { candidates: [], opts: [] }
    }
  }
  pass: {|prefix, spans|
    try {
      ls ~/.password-store/**/*.gpg
      | get name
      | each {$in | str replace -r '^.*?\.password-store/(.*).gpg' '${1}'}
    } catch {
      []
    }
  }
}

def nufzf [] {
  $in | each { |i| $i | to json --raw }
      | str join "\n"
      | fzf -m
      | lines
      | each { $in | from json }
      | reduce { |it, acc| $acc | append $it }
}

