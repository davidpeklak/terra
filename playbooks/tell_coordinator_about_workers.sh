#!/usr/bin/env bash

# include path to postgres binaries
export PATH=$PATH:/usr/lib/postgresql/11/bin

# change to home directory
cd ~

export LANG="en_US.UTF-8"

# tell coordinator about workers
psql -p 9700 -c "SELECT * from master_add_node('localhost', 9701);" >> /dev/null
psql -p 9700 -c "SELECT * from master_add_node('localhost', 9702);" >> /dev/null
