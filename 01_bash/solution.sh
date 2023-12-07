#!/usr/bin/bash

while read line
do
  [ -z "$line" ] && break
  CURRENT_CONTEXT=""
  folded=$(echo "$line" | fold -w 1)
  for char in ${folded} ; do
    CURRENT_CONTEXT="$CURRENT_CONTEXT$char"
    CURRENT_CONTEXT=$(echo "$CURRENT_CONTEXT" | sed -e 's/one/1ne/;s/two/2wo/;s/three/3hree/;s/four/4our/;s/five/5ive/;s/six/6ix/;s/seven/7even/;s/eight/8ight/;s/nine/9ine/')
  done

  SUM_1=$((SUM_1 + "$(printf %.1s $(echo $CURRENT_CONTEXT | tr -d -c 0-9))$(echo $CURRENT_CONTEXT | tr -d -c 0-9 | tail -c 1)"))
  SUM_2=$((SUM_2 + "$(printf %.1s $(echo $line | tr -d -c 0-9))$(echo $line | tr -d -c 0-9 | tail -c 1)"))
done

echo "Part1: $SUM_1"
echo "Part2: $SUM_2"

