#!/bin/bash -eux

. /etc/environment
export VM_USER=$vmUser

# Apply the KX.AS.CODE Docs configuration files
yamlFiles=$(find . -name "*.yaml")
for yamlFile in $yamlFiles
do
  cat $yamlFile | envhandlebars | kubectl apply -n devops -f -
done

# Install the desktop shortcut
. /home/$VM_USER/Documents/kx.as.code_source/play-pit/base/createDesktopShortcut.sh \
  --name="KX.AS.CODE Docs" \
  --url=https://docs.${baseDomain} \
  --icon=/home/$VM_USER/Documents/kx.as.code_docs/kubernetes/books.png
