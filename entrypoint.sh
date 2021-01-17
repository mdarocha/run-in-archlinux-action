#! /usr/bin/env bash

set -e

script=$1

if [[ -z ${script} ]]; then
    echo "You have to specify the commands to run in docker"
    exit 1;
fi

function make_chown () {
    if [[ ! -z ${GITHUB_WORKSPACE} ]]; then
        chown -R ${1} ${GITHUB_WORKSPACE}
    fi
    if [[ ! -z ${GITHUB_HOME} ]]; then
        chown -R ${1} ${GITHUB_HOME}
    fi
    if [[ ! -z ${HOME} ]]; then
        chown -R ${1} ${HOME}
    fi
}

function clean_up () {
    echo "Cleaning up..."

    user=${USER:=root}
    make_chown ${user}

    rm /tmp/script
}
trap clean_up EXIT

# make archuser the owner of these directories
make_chown archuser

# output script to /tmp/script
cat << EOF > /tmp/script
#! /usr/bin/env bash

set -e

${script}

EOF

# run the script as archuser
echo "Running commands in Arch Linux container"

chmod 755 /tmp/script
sudo -E -u archuser /tmp/script

