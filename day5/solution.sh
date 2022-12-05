#!/opt/homebrew/bin/bash

crate_char_index=(1 5 9 13 17 21 25 29 33)

stacks=()
function put_in_stack() {
  stacks[i]="${stacks[i]}${crate}"
}

function move_crates() {
  from_stack="${stacks[from]}"
  to_move=$(echo "${from_stack:0:$qty}")

  if [ "$CRANE_MODEL" == "9000" ]; then
    to_move=$(rev <<< $to_move)
  fi

  stacks[from]=${from_stack:$qty}
  to_stack="${stacks[to]}"
  stacks[to]="${to_move}${to_stack}"
}

function get_top_crates() {
  for crates in ${stacks[@]}; do
    echo ${crates:0:1}
  done
}


IFS=''

function solve() {
  while read -r line; do
    if [[ $line =~ "[" ]]; then
      for i in "${!crate_char_index[@]}"; do
        char_count="${crate_char_index[$i]}"
        crate="${line:char_count:1}"
        if [[ "$crate" != " " ]]; then
          put_in_stack
        fi
      done
    fi


    if [[ $line =~ "move" ]]; then
      qty=$(cut -d " " -f 2 <<< "$line")
      from=$(( $(cut -d " " -f 4 <<< "$line") - 1 ))
      to=$(( $(cut -d " " -f 6 <<< "$line") - 1 ))
      move_crates
    fi
  done < input.txt
}

echo "part 1" #TDCHVHJTG
CRANE_MODEL=9000
solve
get_top_crates

echo "part 2" #TDCHVHJTG
CRANE_MODEL=9001
solve
get_top_crates

