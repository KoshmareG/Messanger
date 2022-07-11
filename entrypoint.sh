#!/bin/bash
set -e

rm -f /Messanger/tmp/pids/server.pid

exec "$@"