#!/bin/bash -e

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

#cd "/media/daniell/Windows\ 10\ main/Users/Daniell/Desktop/Orgute/peeper-user-daniell-mesquita/.issues"
cd /media/daniell/Windows\ 10\ main/Users/Daniell/Desktop/Orgute/peeper-user-daniell-mesquita/.issues

if [ "$(jq -r '.open' data.json)" = "null" ] || [ "$(jq -r '.open' data.json)" = "" ]; then
   echo "Its your first time using issue-listing.sh!"
   echo "Initializing..."
   #tmp="$(mktemp)"; cat data.json | jq ". += {\"open\":[{\"total\": "",\"items\": [{}]}]}" >"$tmp" && mv "$tmp" data.json
   #tmp="$(mktemp)"; cat data.json | jq ". += {\"closed\":[{\"total\": "",\"items\": [{}]}]}" >"$tmp" && mv "$tmp" data.json
   #tmp="$(mktemp)"; cat data.json | jq ". += {\"open\":[{\"total\": ""}]}" >"$tmp" && mv "$tmp" data.json
   #tmp="$(mktemp)"; cat data.json | jq ". += {\"closed\":[{\"total\": ""}]}" >"$tmp" && mv "$tmp" data.json
   #tmp="$(mktemp)"; cat data.json | jq ". += {\"open\":[{\"total\": \"\"}]}" >"$tmp" && mv "$tmp" data.json #- works
   #tmp="$(mktemp)"; cat data.json | jq ". += {\"closed\":[{\"total\": \"\"}]}" >"$tmp" && mv "$tmp" data.json #- works
   tmp="$(mktemp)"; cat data.json | jq ". += {\"open\":[{\"total\": \"\",\"items\": [{}]}]}" >"$tmp" && mv "$tmp" data.json
   tmp="$(mktemp)"; cat data.json | jq ". += {\"closed\":[{\"total\": \"\",\"items\": [{}]}]}" >"$tmp" && mv "$tmp" data.json
fi

. "$SCRIPTPATH/./function_process_issues.sh"

currenttype="open"
process_issues
currenttype="closed"
process_issues
