#!/bin/bash -eux

. /etc/environment
export VM_USER=$VM_USER

# Delete KX-AS.CODE Docs deployment from Kubernetes
kubectl delete \
  -f deployment.yaml \
  -f ingress.yaml \
  -f service.yaml \
  -n devops

# Delete desktop shortcut
/home/$VM_USER/Documents/git/kx.as.code_library/02_Kubernetes/00_Base/removeDesktopShortcut.sh --name="KX.AS.CODE Docs"