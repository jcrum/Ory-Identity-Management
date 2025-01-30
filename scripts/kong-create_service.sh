#!/bin/bash

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <service_name> <upstream>"
  exit 1
fi

service_name="$1"
upstream="$2"

request_data='{
  "name": "'${service_name}'",
  "url": "'${upstream}'"
}'
echo $request_data
response=$(curl -s -X POST 'http://localhost:8001/services' \
  -H 'Content-Type: application/json' \
  -H 'accept: application/json' \
  --data "$request_data")

IFS=$'\n' read -r -d '' body code exitcode <<<"$response"

echo $body
