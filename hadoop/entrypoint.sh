#!/usr/bin/env bash

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

hdfs namenode -format

hadoop-daemon.sh start namenode

hadoop datanode start
