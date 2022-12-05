#!/opt/homebrew/bin/bash

declare -A stacks
crate_index=(1 5 9 13 17 21 25 29 33)

function print_stacks() {
  echo "${stack_0[@]}"
  echo "${stack_1[@]}"
  echo "${stack_2[@]}"
  echo "${stack_3[@]}"
  echo "${stack_4[@]}"
  echo "${stack_5[@]}"
  echo "${stack_6[@]}"
  echo "${stack_7[@]}"
  echo "${stack_8[@]}"
}

function put_in_stack() {
  if [[ $i == 0 ]]; then
    stack_0+=($crate)
  fi
  if [[ $i == 1 ]]; then
    stack_1+=($crate)
  fi
  if [[ $i == 2 ]]; then
    stack_2+=($crate)
  fi
  if [[ $i == 3 ]]; then
    stack_3+=($crate)
  fi
  if [[ $i == 4 ]]; then
    stack_4+=($crate)
  fi
  if [[ $i == 5 ]]; then
    stack_5+=($crate)
  fi
  if [[ $i == 6 ]]; then
    stack_6+=($crate)
  fi
  if [[ $i == 7 ]]; then
    stack_7+=($crate)
  fi
  if [[ $i == 8 ]]; then
    stack_8+=($crate)
  fi
}

function make_move() {
  echo "FROM: ${from}"
  if [[ $from == 0 ]]; then
    to_move=${stack_0[@]:0:$qty}
    stack_0=${stack_0[@]:$qty}
    move_to
  fi
  if [[ $from == 1 ]]; then
    to_move=${stack_1[@]:0:$qty}
    stack_1=${stack_1[@]:$qty}
    move_to
  fi
  if [[ $from == 2 ]]; then
    to_move=${stack_2[@]:0:$qty}
    stack_2=${stack_2[@]:$qty}
    move_to
  fi
  if [[ $from == 3 ]]; then
    stack_3+=($crate)
  fi
  if [[ $from == 4 ]]; then
    stack_4+=($crate)
  fi
  if [[ $from == 5 ]]; then
    stack_5+=($crate)
  fi
  if [[ $from == 6 ]]; then
    stack_6+=($crate)
  fi
  if [[ $from == 7 ]]; then
    stack_7+=($crate)
  fi
  if [[ $from == 8 ]]; then
    stack_8+=($crate)
  fi
}

function move_to() {
  for crate_to_move in $to_move; do
    echo "moving ${crate_to_move}"
      if [[ $to == 0 ]]; then
        stack_0+=($crate_to_move)
      fi
      if [[ $to == 1 ]]; then
        stack_1+=($crate_to_move)
      fi
      if [[ $to == 2 ]]; then
        stack_2+=($crate_to_move)
      fi
      if [[ $to == 3 ]]; then
        stack_3+=($crate_to_move)
      fi
      if [[ $to == 4 ]]; then
        stack_4+=($crate_to_move)
      fi
      if [[ $to == 5 ]]; then
        stack_5+=($crate_to_move)
      fi
      if [[ $to == 6 ]]; then
        stack_6+=($crate_to_move)
      fi
      if [[ $to == 7 ]]; then
        stack_7+=($crate_to_move)
      fi
      if [[ $to == 8 ]]; then
        stack_8+=($crate_to_move)
      fi
  done
}


IFS=''
while read -r line; do
  print_stacks
  if [[ $line =~ "[" ]]; then
    for i in "${!crate_index[@]}"; do
      char_count="${crate_index[$i]}"
      crate="${line:char_count:1}"
      if [[ "$crate" != " " ]]; then
        put_in_stack
      fi
    done
  fi

  if [[ $line =~ "move" ]]; then
    echo "doing move: ${line}"
    qty=$(cut -d " " -f 2 <<< "$line")
    from=$(( $(cut -d " " -f 4 <<< "$line") - 1 ))
    to=$(( $(cut -d " " -f 6 <<< "$line") - 1 ))
    make_move
  fi
done < sample_input.txt
echo ${stack_0[@]}
