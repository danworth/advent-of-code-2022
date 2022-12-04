#!/bin/bash

function total_overlap() {
  if [[ $elf_two_low -ge $elf_one_low ]] && \
     [[ $elf_two_high -le $elf_one_high ]]; then
    return 0
  fi

  if [[ $elf_one_low -ge $elf_two_low ]] && \
     [[ $elf_one_high -le $elf_two_high ]]; then
    return 0
  fi

  return 1
}

function any_overlap() {
  if [[ $elf_two_low -ge $elf_one_low ]] && \
     [[ $elf_two_low -le $elf_one_high ]]; then
    return 0
  fi

  if [[ $elf_one_low -ge $elf_two_low ]] && \
     [[ $elf_one_low -le $elf_two_high ]]; then
    return 0
  fi

  if [[ $elf_two_high -le $elf_one_high ]] && \
     [[ $elf_two_high -ge $elf_one_low ]]; then
    return 0
  fi

  if [[ $elf_one_high -le $elf_two_high ]] && \
     [[ $elf_one_high -ge $elf_two_low ]]; then
    return 0
  fi

  return 1
}

while read -r line; do
  if [ -z "$line" ]; then
    continue
  fi

  elf_one=$(cut -d ',' -f 1 <<< "$line")
  elf_two=$(cut -d ',' -f 2 <<< "$line")

  elf_one_low=$(cut -d '-' -f 1 <<< "$elf_one")
  elf_one_high=$(cut -d '-' -f 2 <<< "$elf_one")
  elf_two_low=$(cut -d '-' -f 1 <<< "$elf_two")
  elf_two_high=$(cut -d '-' -f 2 <<< "$elf_two")

  if total_overlap; then
    (( part_1_total += 1 ))
    (( part_2_total += 1 ))
  elif any_overlap; then
    (( part_2_total += 1 ))
  fi
done < input.txt

echo "Part 1: ${part_1_total}" # 456
echo "Part 2: ${part_2_total}" # 808
