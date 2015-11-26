#!/bin/bash
#
# Set up a shared pyenv for Python 2 and Python 3

# Log commands and exit on error.
set -xe

# Pyenv requires we specify the *exact* Python version when installing
py2_version="2.7.10"
py3_version="3.5.0"

pyenv_root="/opt/pyenv"
pyenv_bashrc="${pyenv_root}/bashrc"

# Setup pyenv
git clone --depth=1 https://github.com/yyuu/pyenv.git "${pyenv_root}"
echo "export PYENV_ROOT=\"${pyenv_root}\"" >> "${pyenv_bashrc}"
echo 'export PATH="${PYENV_ROOT}/bin:${PATH}"' >> "${pyenv_bashrc}"
echo 'eval "$(pyenv init -)"' >> "${pyenv_bashrc}"

# We want to use pyenv below so source the configuration we wrote above
source "${pyenv_bashrc}"

# Install Python versions
export PYTHON_CONFIGURE_OPTS="--enable-shared"
pyenv install ${py2_version}
pyenv install ${py3_version}

# Use pyenv installed Pythons in preference to system Python and within those
# versions prefer Python 3. Set the configuration in the /repo volume.
pyenv global ${py3_version} ${py2_version}

# Now install tox so that we can run the test suite
pip install tox

# Ensure that everyone can read the contents of the global pyenv
chmod oug+rX "${pyenv_root}"

