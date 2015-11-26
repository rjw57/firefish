#!/bin/bash
#
# Install software within the Docker container.

# Log commands and exit on error
set -xe

# Refresh the apt package cache and install the apt repository management
# tooling along with the dependencies required by pyenv.
sudo apt-get -y update
sudo apt-get -y install software-properties-common git \
    make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev

# Add OpenFOAM Ubuntu package repository
sudo add-apt-repository -y http://www.openfoam.org/download/ubuntu

# Refresh apt cache from new repositories
sudo apt-get -y update

# Install openfoam. Annoyingly openfoam do not appear to sign their packages so
# we have to trust that $BAD_GUYS are not in the middle of our connection. Apt
# will only install unsigned packages with --force-yes.
sudo apt-get -y --force-yes install openfoam30

