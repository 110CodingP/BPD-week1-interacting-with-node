# RPC settings
RPC_USER="codingp110"
RPC_PASSWORD="3XMLDDizJG9XX19Cen3kJlqvaKSD8xponD1xtKp_5aQ"
RPC_HOST="127.0.0.1:18443"
RPC_HOST_WALLET="127.0.0.1:18443/wallet/testwallet"
RPC_AUTH="codingp110:03beb84bf425a999b46111954389d04a\$9958f062ce0ad900c2f77f2fa29a0d7fe75d3adcfb6824e42b27b44a053f3bd9"

# Helper function to make RPC calls
rpc_call() {
  local method=$1
  shift
  local params=$@

  curl -s --user $RPC_USER:$RPC_PASSWORD --data-binary "{\"jsonrpc\": \"1.0\", \"id\":\"curltest\", \"method\": \"$method\", \"params\": $params }" -H 'content-type: text/plain;' http://$RPC_HOST/
}

# Helper function to make wallet RPC calls
rpc_call_wallet() {
  local method=$1
  shift
  local params=$@

  curl -s --user $RPC_USER:$RPC_PASSWORD --data-binary "{\"jsonrpc\": \"1.0\", \"id\":\"curltest\", \"method\": \"$method\", \"params\": $params }" -H 'content-type: text/plain;' http://$RPC_HOST_WALLET
}

# Check Connection
info=$(rpc_call "getblockcount" "[]")
echo $info

# Create and load wallet
info=$(rpc_call "createwallet" '["testwallet"]')
echo $info
info=$(rpc_call "loadwallet" '["testwallet"]')
echo $info

# Generate a new address
info=$(rpc_call_wallet "getnewaddress" "[]")
echo $info
addr=$(jq -r '.result' <<< "${info}")
echo $addr
# Mine 103 blocks to the new address
info=$(rpc_call "generatetoaddress" "["103", \"$addr\"]" )
echo $info

# Send the transaction
txn=$(rpc_call_wallet 'send' "[[{\"bcrt1qq2yshcmzdlznnpxx258xswqlmqcxjs4dssfxt2\":100},{\"data\":\"57652061726520616C6C205361746F7368692121\"}],null,\"unset\",25,null]")
echo $txn

# Output the transaction ID to a file
res=$(jq -r '.result' <<< "${txn}")
txid=$(jq -r '.txid' <<< "${res}")
echo $txid > ../out.txt
