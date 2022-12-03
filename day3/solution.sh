#!/bin/bash

function convert_to_priority() {
  char=$1
  num_val=$(printf "%d" \'"$char")

  if (( num_val < 97 )); then
    echo $(( num_val - 38 ))
    return
  fi

  echo $(( num_val - 96 ))
}

while read -r line; do
  if [ -z "$line" ]; then
    continue
  fi

  length="${#line}"
  first_bag="${line:0:length/2}"
  second_bag="${line:length/2}"

  items=()
  while read -r item; do
    if [ -z "$item" ]; then
      continue
    fi

    item_priority=$(convert_to_priority "$item")
    items["$item_priority"]=$(( items["$item_priority"] + 1 ))
  done < <( grep -o . <<< "$first_bag")

  while read -r item; do
    if [ -z "$item" ]; then
      continue
    fi

    item_priority=$(convert_to_priority "$item")

    if [[ ${items["$item_priority"]} -gt 0 ]]; then
      part_1_total=$(( part_1_total + item_priority ))
      break
    fi
  done < <( grep -o . <<< "$second_bag")
done < input.txt

echo $part_1_total

echo "part 2:"

count=0
back_packs=()
while read -r line; do
  if [ $count == 3 ]; then
    for i in "${!back_packs[@]}"; do
      if [ "${back_packs["$i"]}" = 3 ]; then
        part_2_total=$(( part_2_total + i ))
      fi
    done
    count=0
    back_packs=()
  fi

  unique_items=$( grep -o . <<< "$line" | sort | uniq)
  while read -r item; do
    if [ -z "$item" ]; then
      continue
    fi

    item_priority=$(convert_to_priority "$item")
    back_packs["$item_priority"]=$(( back_packs["$item_priority"] + 1 ))
  done < <(echo "$unique_items")


  count=$(( count + 1 ))
done < input.txt

echo $part_2_total

