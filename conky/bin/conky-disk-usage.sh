#!/usr/bin/env bash

main() {
  local disk

  for disk in / /home /var/remise $(df | grep -o ' /media.*'); do
    echo -n "\${if_existing ${disk}}"
    echo -n "\${font} $(basename "${disk}") \${alignr}\${fs_used ${disk}} / \${fs_size ${disk}} (\${fs_used_perc ${disk}}%) "
    echo -n "\${if_match \${fs_used_perc ${disk}} >= 90}\${color #CD5C5C}\${else}"
    echo -n "\${if_match \${fs_used_perc ${disk}} >= 70}\${color #FFC274}\${else}"
    echo -n "\${if_match \${fs_used_perc ${disk}} >= 50}\${color #5F9EA0}\${endif}\${endif}\${endif}"
    echo -n "\${fs_bar ${disk}}\${color}\${endif}"
    echo
  done
}

main "$@"
