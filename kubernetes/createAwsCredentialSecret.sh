#!/bin/bash

# This is required before deploying the Tech Radar container to Kubernetes!

# The below assumes that a login to AWS has already occured and the
# Docker credential file is already in place
kubectl create secret generic regcred \
    --from-file=.dockerconfigjson=$HOME/.docker/config.json \
    --type=kubernetes.io/dockerconfigjson
