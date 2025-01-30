#!/bin/bash

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <service_name> <route_name> <route_path>"
fi

service_name="$1"
route_name="$2"
route_path="$3"

request_data='{
  "paths": ["'${route_path}'"],
  "name": "'${route_name}'"
}'

echo $request_data

response=$(curl -s -X POST 'http://localhost:8001/services/'${service_name}'/routes' \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  --data "${request_data}")

IFS=$'\n' read -r -d '' body code exitcode <<<"$response"

echo $body
