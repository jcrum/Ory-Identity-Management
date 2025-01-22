#!/bin/sh


delete_user() {
  local client_name="$1"
  local client_id="$2"
  echo "Deleting user ${client_name} - ${client_id}"
  curl -X DELETE "http://localhost:4445/admin/clients/${client_id}"
}


# get the directory of this script
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 'execute' the script
clients=$(source ${__dir}/client-get_clients.sh)


# Loop over each client as prompt the user to delete the record
echo "$clients" | while IFS=":" read -r client_name client_id; do
    # Trim whitespace
    client_name=$(echo "${client_name}" | xargs)
    client_id=$(echo "${client_id}" | xargs)

    # Prompt the user for confirmation
    echo "Do you want to delete ${client_name}? (y/N)"
    # Use `/dev/tty` for input to ensure `read` works properly
    read -r response < /dev/tty

    # Check the user's response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        delete_user "${client_name}" "${client_id}"
    else
        echo "Skipped ${client_name}"
    fi
done
