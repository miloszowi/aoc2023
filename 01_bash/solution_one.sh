#!/usr/bin/bash

while read line
do
  [ -z "$line" ] && break
    SUM=$((SUM + "$(printf %.1s $(echo $line | tr -d -c 0-9))$(echo $line | tr -d -c 0-9 | tail -c 1)"))
done

echo "$SUM"

