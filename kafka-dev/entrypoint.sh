#!/usr/bin/env bash
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

zookeeper-server-start.sh /kafka/config/zookeeper.properties &
echo "*** waiting for 10 secs to give ZooKeeper time to start up"
sleep 10

echo "# ============================================================================ #"
echo "                         S t a r t i n g   K a f k a"
echo "# ============================================================================ #"
kafka-server-start.sh /kafka/config/server.properties

