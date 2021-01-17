#! /usr/bin/env bash

set -e

script=$1

if [[ -z ${script} ]]; then
    echo "You have to specify the commands to run in docker"
    exit 1;
fi

function clean_up () {
    echo "Cleaning up..."

    if [[ ! -z ${GITHUB_WORKSPACE} ]]; then
        chown -R ${USER} ${GITHUB_WORKSPACE}
    fi

    if [[ ! -z ${GITHUB_HOME} ]]; then
        chown -R ${USER} ${GITHUB_HOME}
    fi

    rm /tmp/script
}
trap clean_up EXIT

# make archuser the owner of these directories
if [[ ! -z ${GITHUB_WORKSPACE} ]]; then
    chown -R archuser ${GITHUB_WORKSPACE}
fi

if [[ ! -z ${GITHUB_HOME} ]]; then
    chown -R archuser ${GITHUB_HOME}
fi

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

