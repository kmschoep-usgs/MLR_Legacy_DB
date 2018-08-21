#!/bin/ash 

# Restart postgres to make sure we can connect
pg_ctl -D "$PGDATA" -m fast -o "$LOCALONLY" -w restart

echo "restarted postgres from new script"
echo $LOCALONLY