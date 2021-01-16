#! /usr/bin/env bash

set -e

script=$1

chown -R archuser ${GITHUB_WORKSPACE}

sudo -u archuser bash -c "${script}"
