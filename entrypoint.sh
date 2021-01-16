#! /usr/bin/env bash

set -e

script=$1

if [[ ! -z ${GITHUB_WORKSPACE} ]]; then
    chown -R archuser ${GITHUB_WORKSPACE}
fi

cat << EOF > /tmp/script
#! /usr/bin/env bash

set -e

${script}

EOF

chmod 755 /tmp/script

sudo -E -u archuser /tmp/script

# cleanup
if [[ ! -z ${GITHUB_WORKSPACE} ]]; then
    chown -R root ${GITHUB_WORKSPACE}
fi

rm /tmp/script
