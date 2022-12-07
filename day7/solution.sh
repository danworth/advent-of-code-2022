#!/opt/homebrew/bin/bash

declare -A dirs=()

echo "Reading directory tree"
while read -r line; do
  if [[ -z "$line" ]]; then
    continue
  fi

  if [[ "$line" =~ "$ cd" ]]; then
    if [[ "$line" == '$ cd ..' ]]; then
      pwd="${pwd%:*}"
    else
      dir=$(cut -d ' ' -f 3 <<< "$line")
      pwd+=":${dir}"
    fi
  fi

  if [[ "$line" =~ ^[0-9]+ ]]; then
    file_size="$(cut -d ' ' -f 1 <<< "$line")"
    (( dirs[$pwd] += file_size ))
  fi
done < input.txt

echo "Calculating total directory sizes"
declare -A total_sizes=()

for dir in "${!dirs[@]}"; do
  size="${dirs[$dir]}"
  (( total_sizes[$dir] += size ))

  parent_dir="${dir%:*}"
  while [[ -n "$parent_dir" ]]; do
    (( total_sizes[$parent_dir] += size ))
    parent_dir="${parent_dir%:*}"
  done
done

echo "Finding directories within limit"
for dir in "${!total_sizes[@]}"; do
  size=${total_sizes[$dir]}
  if [[ "$size" -le 100000 ]]; then
    (( total += size ))
  fi
done

echo "part 1: ${total}"

echo "Finding directory to delete for update"
MAX_SYSTEM_SPACE=70000000
UPDATE_SIZE=30000000

available_space=$(( MAX_SYSTEM_SPACE - total_sizes[":/"] ))
required_space=$(( UPDATE_SIZE - available_space ))
space_to_delete=70000000

for dir in "${!total_sizes[@]}"; do
  size=${total_sizes[$dir]}
  if [[ "$size" -ge "$required_space" ]]; then
    if [[ "$size" -lt "$space_to_delete" ]]; then
      space_to_delete="$size"
    fi
  fi
done

echo "Part 2: $space_to_delete"

