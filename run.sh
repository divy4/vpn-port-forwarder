#!/bin/ash

set -e

target_addr='TARGET_ADDR'
target_port='TARGET_PORT'
vpn_server='VPN_SERVER'
vpn_cert='VPN_CERT'
vpn_group='VPN_GROUP'
vpn_user='VPN_USER'

echo 'Setting up vpn...'
set +e
openconnect "$vpn_server" \
  --authgroup="$vpn_group" \
  --background \
  --servercert "$vpn_cert" \
  --user="$vpn_user"
set -e
vpn_pid="$(pgrep openconnect | tail -1)"
if [ -z "$vpn_pid" ]; then
  echo 'openconnect process not found!'
  exit 1
fi

echo "Forwarding port $target_port..."
socat "TCP-LISTEN:$target_port,fork" "TCP:$target_addr:$target_port" &
socat_pid="$!"
echo 'Done!'

echo 'Press enter to stop forwarding and exit the vpn.'
read -r

kill -15 "$socat_pid"
kill -15 "$vpn_pid"
echo 'Done!'
