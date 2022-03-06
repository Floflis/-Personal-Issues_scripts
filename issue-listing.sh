#!/bin/bash -e

cd /media/daniell/Windows\ 10\ main/Users/Daniell/Desktop/Orgute/peeper-user-daniell-mesquita/.issues/open

tmp="$(ls --file-type *.json | sort -n)" #- credits: https://www.unix.com/302856521-post4.html
echo "$tmp" > tmp.txt.tmp
#echo $tmp > tmp.txt
#tmp2="$(cat tmp.txt)"
#tmp2="$(echo $tmp)"
#rm tmp.txt
#formated="${tmp2%.*}"

while IFS="" read -r p || [ -n "$p" ]
do
  formated="${p%.*}"
  echo "$formated"
  #printf '%s\n' "$p"
done < tmp.txt.tmp
#- credits: https://stackoverflow.com/a/1521498/5623661

rm tmp.txt.tmp

#echo "$formated"
