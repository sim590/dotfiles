#!/bin/bash

main() {
  local dir len file size lines

  dir="${1%/}"
  len="${#dir}"
  lines="${2:-5}"

  find "${dir}" -type f -size +100M -exec du -Sh {} + | sort -rh | head -n "${lines}" | while read -r size file; do
    file="${file:$((len+1))}"
    if [ ${#file} -gt 38 ]; then
      file="...${file: -38}"
    fi
    echo "${file}\${alignr}${size}"
  done
}

## \usage conky-biggest-files DIRECTORY [LINES]
main "$@"