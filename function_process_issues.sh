#!/bin/bash -e

process_issues () {
cd "$currenttype"

tmp="$(ls --file-type *.json | sort -n)" #- credits: https://www.unix.com/302856521-post4.html
echo "$tmp" > tmp.txt.tmp

loopmile="0"

while IFS="" read -r p || [ -n "$p" ]
do
  cd ..
  formated="${p%.*}"
  echo "$formated"
  tmp="$(mktemp)"; cat data.json | jq ".\"$currenttype\"[] += {\"$loopmile\":\"$formated\"}" >"$tmp" && mv "$tmp" data.json
  #printf '%s\n' "$p"
  loopmile="$(($loopmile + 1))"
  echo "Loop: $loopmile"
  cd "$currenttype"
done < tmp.txt.tmp
rm tmp.txt.tmp
cd ..

}
