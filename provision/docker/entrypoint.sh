#!/bin/bash

## Find the tox test runner
#TOX=$(which tox)
#if [ -z "${TOX}" ]; then
#    echo "error: tox not found in pyenv"
#    exit 1
#fi

test_user="testrunner"
test_home="/home/${test_user}"

# We want to run tox in the repository volume as the user which owns that
# directory.
repo_dir=/repo
repo_user=$(stat -c '%u' "${repo_dir}")

# Remove test user if they exist
if id -u "${test_user}" 2>/dev/null; then
    userdel --force "${test_user}"
fi

# Create test user
useradd --uid "${repo_user}" --home "${test_home}" \
    --create-home "${test_user}" --shell "$(which bash)"

# Add test runner script for user
cat >> "${test_home}/run.sh" <<__EOF__
#!/bin/bash

# Exit on error
set -x

# Enable OpenFOAM
source /opt/openfoam30/etc/bashrc

# Enable shared pyenv
source /opt/pyenv/bashrc

cd "${repo_dir}"
exec tox
__EOF__
chown "${test_user}" "${test_home}/run.sh"
chmod +x "${test_home}/run.sh"

# Run test suite via test runner script
exec su -l -c "${test_home}/run.sh" "${test_user}"

