#!/bin/bash

cpu_cycle=0
sprite_centre=1
screen=()

function should_draw() {
  [[ "$crt" -ge "$(( sprite_centre - 1 ))" ]] && \
  [[ "$crt" -le "$(( sprite_centre + 1 ))" ]];
}

function increment_cpu_cycle() {
  cycles="$1"

  for (( i= 0; i<"$cycles"; i++ )); do
    (( cpu_cycle += 1 ))

    row=$(( ( cpu_cycle - 1 ) / 40 ))
    crt=$(( ( cpu_cycle - 1 ) % 40 ))

    should_draw && char="#" || char=" "
    screen["$row"]+="$char"
  done
}

while read -r line; do

  if [[ -z "$line" ]]; then
    continue
  fi

  instruction="${line% *}"

  case "$instruction" in
    "noop")
      increment_cpu_cycle 1
      ;;
     "addx")
       magnitude="${line#* }"
       increment_cpu_cycle 2
      (( sprite_centre += magnitude ))
       ;;
     *)
       echo "Unknown instruction"
       exit 1
       ;;
   esac
done < input.txt

for row in "${screen[@]}"; do
  echo "$row"
done


