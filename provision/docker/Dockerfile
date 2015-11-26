FROM ubuntu:14.04
MAINTAINER Rich Wareham <rich.m3cfd@richwareham.com>

# Install system dependencies
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
ADD install.sh /tmp/docker/
RUN /tmp/docker/install.sh

# Create pyenvs for Python 3 and 2
COPY setup-pyenv.sh /tmp/docker/
RUN /tmp/docker/setup-pyenv.sh

# Install specific development packages required by Python modules
RUN apt-get -y install libfreetype6-dev libpng12-dev

VOLUME /repo

# Copy entrypoint script
ADD entrypoint.sh /tmp/docker/
ENTRYPOINT ["/tmp/docker/entrypoint.sh"]
