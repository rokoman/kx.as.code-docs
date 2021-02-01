#!/bin/bash -eux

. /etc/environment
export VM_USER=$vmUser

# Install Python Dependencies
pip3 install -r requirements.txt
export PATH=$PATH:/home/$VM_USER/.local/bin

# Copy Latest README.md Docs
. /usr/share/kx.as.code/git/kx.as.code_docs/createKxDocs.sh

# Build Site
mkdocs build --clean

# Build KX.AS.CODE Docs Docker Image
docker build -t ${dockerRegistryDomain}/kx-as-code/docs:latest .
