#!/usr/bin/env bash

# include path to postgres binaries
export PATH=$PATH:/usr/lib/postgresql/11/bin

# change to home directory
cd ~

mkdir -p citus/coordinator citus/worker1 citus/worker2

export LANG="en_US.UTF-8"
echo $LANG

# create three normal postgres instances
initdb -D citus/coordinator
initdb -D citus/worker1
initdb -D citus/worker2

# citus is a Postgres extension, to tell Postgres to use this extension we need to add it to a
# configuration variable called shared_preload_libraries
echo "shared_preload_libraries = 'citus'" >> citus/coordinator/postgresql.conf
echo "shared_preload_libraries = 'citus'" >> citus/worker1/postgresql.conf
echo "shared_preload_libraries = 'citus'" >> citus/worker2/postgresql.conf
