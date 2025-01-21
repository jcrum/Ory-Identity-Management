#!/bin/bash

# Check if the required number of arguments is provided
if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <client_name> <client_secret>"
  exit 1
fi

# Assign positional arguments to variables
client_name="$1"
client_secret="$2"

request_data='{ 
  "access_token_strategy": "opaque", 
  "client_name": "'${client_name}'", 
  "client_secret": "'${client_secret}'", 
  "grant_types": ["client_credentials"], 
  "scope": "api" 
}'

response=$(curl -s -X POST 'http://localhost:4445/admin/clients' \
  -H 'Content-Type: application/json' \
  --data-raw "${request_data}")

IFS=$'\n' read -r -d '' body code exitcode <<<"$response"

client_id=$(echo "$body" | jq -r '.client_id')

# Print the client_id
echo "Client ID: $client_id"
