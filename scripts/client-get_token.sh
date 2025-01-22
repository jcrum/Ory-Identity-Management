#!/bin/sh

if [[ $# -lt 2 ]]; then
  echo "Usage $0 <client_id> <client_password>"
  exit 1
fi

client_id="$1"
client_password="$2"

response=$(curl -s -u "${1}:${2}" \
  -X POST 'http://localhost:4444/oauth2/token' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  --data-raw 'grant_type=client_credentials&scope=api')

IFS=$'\n' read -r -d '' body code exitcode <<<"$response"

client_token=$(echo "$body" | jq -r '.access_token')

echo $client_token
