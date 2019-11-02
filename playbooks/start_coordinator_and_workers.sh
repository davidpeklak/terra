#!/usr/bin/env bash

# include path to postgres binaries
export PATH=$PATH:/usr/lib/postgresql/11/bin

# change to home directory
cd ~

# start the databases
pg_ctl -D citus/coordinator -o "-p 9700" -l coordinator_logfile start
pg_ctl -D citus/worker1 -o "-p 9701" -l worker1_logfile start
pg_ctl -D citus/worker2 -o "-p 9702" -l worker2_logfile start
