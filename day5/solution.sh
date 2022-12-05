#!/bin/bash

CRATE_CHAR_INDEX=(1 5 9 13 17 21 25 29 33)
IFS=''

function move_crates() {
  local command="$1"

  local qty=$(cut -d " " -f 2 <<< "$command")
  local from=$(( $(cut -d " " -f 4 <<< "$command") - 1 ))
  local to=$(( $(cut -d " " -f 6 <<< "$command") - 1 ))

  local from_stack="${stacks[from]}"
  local crates_to_move="${from_stack:0:$qty}"
  local crates_remaining="${from_stack:$qty}"

  if [ "$CRANE_MODEL" == "9000" ]; then
    crates_to_move=$(rev <<< "$crates_to_move")
  fi

  stacks[from]=${crates_remaining}
  stacks[to]="${crates_to_move}${stacks[to]}"
}

function load_stacks() {
  local command="$1"

  for stack_number in "${!CRATE_CHAR_INDEX[@]}"; do
    local char_index="${CRATE_CHAR_INDEX[$stack_number]}"
    local crate="${command:char_index:1}"
    if [[ "$crate" != " " ]]; then
      stacks[stack_number]+="${crate}"
    fi
  done
}

function get_top_crates() {
  for crates in "${stacks[@]}"; do
    echo "${crates:0:1}"
  done
}

function solve() {
  stacks=()
  while read -r line; do
    if [[ "$line" =~ "[" ]]; then
      load_stacks "$line"
    elif [[ $line =~ "move" ]]; then
      move_crates "$line"
    fi
  done < input.txt
  get_top_crates
}

echo "part 1" #TDCHVHJTG
CRANE_MODEL=9000
solve

echo "part 2" #NGCMPJLHV
CRANE_MODEL=9001
solve

