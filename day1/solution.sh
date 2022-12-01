#!/bin/bash

function calories_per_elf() {
  while read -r line; do
    if [ -z "$line" ]; then
      echo "$current_elf"
      current_elf=0
    fi

    current_elf=$((current_elf + line))
  done < input.txt
}

echo "part 1: $(calories_per_elf | sort -rn | head -n 1)"
echo "part 2: $(calories_per_elf | sort -rn | head -n 3 | paste -sd+ - | bc)"
