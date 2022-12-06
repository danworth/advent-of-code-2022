#!/opt/homebrew/bin/bash

function solve() {
  local signal="$1"
  local start_signal_size="$2"
  local -A chars

  for (( i=0; i<${#signal}; i++ )); do
    chars=()
    slice="${signal:i:$start_signal_size}"

    for (( n=0; n<${#slice}; n++ )); do
      char="${slice:$n:1}"
      if (( chars[$char] > 0 )); then
        continue 2 # continue outer loop
      fi

      (( chars[$char] += 1 ))
    done

    echo "$(( i + start_signal_size ))"
    return
  done
}

echo "part 1:"
solve "$(cat input.txt)" 4

echo "part 2:"
solve "$(cat input.txt)" 14

