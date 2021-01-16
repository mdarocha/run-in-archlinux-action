#! /usr/bin/env bash

set -e

script=$1

if [[ ! -z ${GITHUB_WORKSPACE} ]]; then
    chown -R archuser ${GITHUB_WORKSPACE}
fi

sudo -u archuser bash -c "${script}"

if [[ ! -z ${GITHUB_WORKSPACE} ]]; then
    chown -R root ${GITHUB_WORKSPACE}
fi
