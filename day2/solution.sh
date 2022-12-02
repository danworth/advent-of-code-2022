#!/bin/bash

WIN=6; LOSE=0; DRAW=3
ROCK=1; PAPER=2; SCISSORS=3

echo "part 1:"
sed -e "s/A X/$(( ROCK + DRAW ))/" \
    -e "s/A Y/$(( PAPER + WIN ))/" \
    -e "s/A Z/$(( SCISSORS + LOSE ))/" \
    -e "s/B X/$(( ROCK + LOSE ))/" \
    -e "s/B Y/$(( PAPER + DRAW ))/" \
    -e "s/B Z/$(( SCISSORS + WIN ))/" \
    -e "s/C X/$(( ROCK + WIN ))/" \
    -e "s/C Y/$(( PAPER + LOSE ))/" \
    -e "s/C Z/$(( SCISSORS + DRAW ))/" input.txt \
    | paste -sd+ - \
    | bc

echo "part 2:"
sed -e "s/A X/$(( SCISSORS + LOSE ))/" \
    -e "s/A Y/$(( ROCK + DRAW ))/" \
    -e "s/A Z/$(( PAPER + WIN ))/" \
    -e "s/B X/$(( ROCK + LOSE ))/" \
    -e "s/B Y/$(( PAPER + DRAW ))/" \
    -e "s/B Z/$(( SCISSORS + WIN ))/" \
    -e "s/C X/$(( PAPER + LOSE ))/" \
    -e "s/C Y/$(( SCISSORS + DRAW ))/" \
    -e "s/C Z/$(( ROCK + WIN ))/" input.txt \
    | paste -sd+ - \
    | bc

