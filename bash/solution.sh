# RPC settings
RPC_USER="codingp110"
RPC_PASSWORD="3XMLDDizJG9XX19Cen3kJlqvaKSD8xponD1xtKp_5aQ"
RPC_HOST="127.0.0.1:18443"
RPC_AUTH="codingp110:03beb84bf425a999b46111954389d04a$9958f062ce0ad900c2f77f2fa29a0d7fe75d3adcfb6824e42b27b44a053f3bd9"

# Helper function to make RPC calls
rpc_call() {
  local method=$1
  shift
  local params=$@

  curl -s --user $RPC_USER:$RPC_PASSWORD --data-binary "{\"jsonrpc\": \"1.0\", \"id\":\"curltest\", \"method\": \"$method\", \"params\": $params }" -H 'content-type: text/plain;' http://$RPC_HOST/
}

# Check Connection
info=$(rpc_call "getblockcount" "[\"\"]")
echo $info

# Create and load wallet

# Generate a new address

# Mine 103 blocks to the new address

# Send the transaction

# Output the transaction ID to a file
