#!/opt/homebrew/bin/bash

tail_vert=0
tail_horz=0

head_vert=0
head_horz=0

declare -A visited=()

function move_tail() {
  horz_diff=$(( head_horz - tail_horz ))
  vert_diff=$(( head_vert - tail_vert ))

  if [[ "${horz_diff#-}" -gt 1 ]]; then
    if (( horz_diff < 0 )); then
      (( tail_horz -= 1 ))
      (( tail_vert += vert_diff ))
    else
      (( tail_horz += 1 ))
      (( tail_vert += vert_diff ))
    fi
  fi

  if [[ "${vert_diff#-}" -gt 1 ]]; then
    if (( vert_diff < 0 )); then
      (( tail_vert -= 1 ))
      (( tail_horz += horz_diff ))
    else
      (( tail_vert += 1 ))
      (( tail_horz += horz_diff ))
    fi
  fi
}

function move_head() {
  local dir="$1"
  local steps="$2"

  while [[ "$steps" -gt 0 ]]; do
    case "$dir" in
      R)
        (( head_horz += 1 ))
        ;;
      L)
        (( head_horz -= 1 ))
        ;;
      U)
        (( head_vert += 1 ))
        ;;
      D)
        (( head_vert -= 1 ))
        ;;
      *)
        echo "Unknown direction ${dir}"
        exit 1
    esac
    move_tail
    (( steps -= 1 ))

    echo "HEAD AT ${head_vert} : ${head_horz}"
    echo "TAIL AT ${tail_vert} : ${tail_horz}"
    visited["${tail_vert}:${tail_horz}"]=1

  done
}

while read -r line; do
  echo $line

  if [[ -z "$line" ]]; then
    continue
  fi

  dir=${line% *}
  steps=${line#* }

  move_head "$dir" "$steps"
done < input.txt

echo "Visited by the tail: ${#visited[@]}"
