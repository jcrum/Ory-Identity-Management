#!/bin/sh
response=$(curl -X GET 'http://localhost:4445/admin/clients' \
--write-out '\nhttp_code=%{http_code}\nexitcode=%{exitcode}\n' --silent --show-error \
--header 'Content-Type: application/json' \
)
IFS=$'\n' read -r -d '' body code exitcode<<< "$response"

echo $body | jq --raw-output 'map([.client_id, .client_name])[] | @tsv' |

while IFS=$'\t' read id name; do
    echo "$name : $id"
done

