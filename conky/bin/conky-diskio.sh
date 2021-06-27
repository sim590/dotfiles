#!/usr/bin/env bash

main() {
  local partition

  for partition in /dev/{sd??,nvme?n?}; do
    echo -n "\${if_existing ${partition}}"
    echo -n "\${font}${partition} io-read: \${diskio_read ${partition}} \${alignr}io-write: \${diskio_write ${partition}}"
    echo
    echo -n "\${font}\${diskiograph_read ${partition} 25,140 C0C0C0 5F9EA0 -t}\${alignr}\${diskiograph_write ${partition} 25,140 C0C0C0 5F9EA0 -t}"
    echo -n "\${endif}"
    echo
  done
}

main "$@"
