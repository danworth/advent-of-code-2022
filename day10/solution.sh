#!/bin/bash

cpu_cycle=0
x=1

signal_strengths=0

function increment_cpu_cycle() {
  cycles="$1"

  for (( i= 0; i<"$cycles"; i++ )); do
    (( cpu_cycle += 1 ))

    if (( ( cpu_cycle - 20 )  % 40 == 0 )); then
      echo "cycle = ${cpu_cycle}: $(( cpu_cycle * x ))"
      (( signal_strengths += ( cpu_cycle * x ) ))
    fi
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
      (( x += magnitude ))
       ;;
     *)
       echo "Unknown instruction"
       exit 1
       ;;
   esac
done < input.txt

echo "Part 1: ${signal_strengths}"

