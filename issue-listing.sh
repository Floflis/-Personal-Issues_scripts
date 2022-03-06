#!/bin/bash -e

#cd "/media/daniell/Windows\ 10\ main/Users/Daniell/Desktop/Orgute/peeper-user-daniell-mesquita/.issues"
cd /media/daniell/Windows\ 10\ main/Users/Daniell/Desktop/Orgute/peeper-user-daniell-mesquita/.issues

if [ "$(jq -r '.open' data.json)" = "null" ] || [ "$(jq -r '.open' data.json)" = "" ]; then
   echo "Its your first time using issue-listing.sh!"
   echo "Initializing..."
   tmp="$(mktemp)"; cat data.json | jq ". += {\"open\":[{}]}" >"$tmp" && mv "$tmp" data.json
   tmp="$(mktemp)"; cat data.json | jq ". += {\"closed\":[{}]}" >"$tmp" && mv "$tmp" data.json
fi

process_issues () {
#if [ "$currenttype" = "open" ]; then
#   
#fi
#if [ "$currenttype" = "closed" ]; then
#   
#fi

#cd /media/daniell/Windows\ 10\ main/Users/Daniell/Desktop/Orgute/peeper-user-daniell-mesquita/.issues/$currenttype
#cd "/media/daniell/Windows\ 10\ main/Users/Daniell/Desktop/Orgute/peeper-user-daniell-mesquita/.issues/$currenttype"
cd "$currenttype"

tmp="$(ls --file-type *.json | sort -n)" #- credits: https://www.unix.com/302856521-post4.html
echo "$tmp" > tmp.txt.tmp

loopmile="0"

while IFS="" read -r p || [ -n "$p" ]
do
  cd ..
  formated="${p%.*}"
  echo "$formated"
  #tmp="$(mktemp)"; cat issues-list.json | jq ".open[] += {\"$loopmile\":[{\"id\": \"\",\"metadata\":\"\",\"name\":\"\",\"description\":\"\",\"image\":\"\",\"blockchain\":\"\"}]}" >"$tmp" && mv "$tmp" issues-list.json
  tmp="$(mktemp)"; cat data.json | jq ".\"$currenttype\"[] += {\"$loopmile\":\"$formated\"}" >"$tmp" && mv "$tmp" data.json
  #printf '%s\n' "$p"
  loopmile="$(($loopmile + 1))"
  echo "Loop: $loopmile"
  cd "$currenttype"
  #rm tmp.txt.tmp
  #cd ..
done < tmp.txt.tmp
#loopmile="0"
#- credits: https://stackoverflow.com/a/1521498/5623661
#cd "$currenttype"
rm tmp.txt.tmp
cd ..

#rm tmp.txt.tmp

}

currenttype="open"
process_issues
currenttype="closed"
process_issues
