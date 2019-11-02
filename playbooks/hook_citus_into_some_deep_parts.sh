#!/usr/bin/env bash

# include path to postgres binaries
export PATH=$PATH:/usr/lib/postgresql/11/bin

# change to home directory
cd ~

export LANG="en_US.UTF-8"

# hook citus into "some deep parts of Postgres"
psql -p 9700 -c "CREATE EXTENSION citus;"
psql -p 9701 -c "CREATE EXTENSION citus;"
psql -p 9702 -c "CREATE EXTENSION citus;"
