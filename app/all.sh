#!/bin/bash
cd /app

# Launch 5 second waiting script
./5sec.sh &
pid_5sec=$!
echo "5sec PID: ${pid_5sec}"

foreman start -d /app
foreman_pid = $!

function control_c() {
  echo "Kill 5sec PID: ${pid_5sec}"
  kill $pid_5sec
  echo "Kill Foreman PID: ${foreman_pid}"
  kill $foreman_pid
}

trap control_c SIGINT
trap control_c SIGTERM

wait $pid_5sec
wait $foreman_pid
