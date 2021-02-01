#!/bin/bash -x

. /etc/environment
export VM_USER=$vmUser

sourceRepoLocation=/usr/share/kx.as.code/git/kx.as.code
tempLocation=/usr/share/kx.as.code/git/kx.as.code_docs/tmp
targetMkDocsLocation=/usr/share/kx.as.code/git/kx.as.code_docs/docs

mkdir -p $tempLocation
mkdir -p $targetMkDocsLocation
cp -rf $sourceRepoLocation/* $tempLocation/
cp -rf /usr/share/kx.as.code/git/kx.as.code_docs/images $targetMkDocsLocation
cp -rf /usr/share/kx.as.code/git/kx.as.code/images/* $targetMkDocsLocation/images/
find $tempLocation -type f -iname "*.md" -exec sed -i '/Zero2Hero_Logo_Black\.png/d' {} +
find $tempLocation -type f -iname "*.md" -exec sed -i '/kxascode_logo_black_small\.png/d' {} +
find $tempLocation -type f -iname "*.md" -exec sed -i '/# README/d' {} +

files=$(find $tempLocation -mindepth 1 -iregex '.*\.\(md\|png\|jpg\)$' -not -path "$tempLocation/base-vm/*" -printf '%P\n')

for file in $files
do
  if [[ "$file" != *'TEMPLATE'* ]] && [[ "$file" != *'WIP'* ]]; then
    echo "File: $file"
    PATH_DEPTH=$(echo $file | grep -o "/" | wc -l)
    if [[ $PATH_DEPTH < 1 ]]; then
      echo "Depth only $PATH_DEPTH. Copy file only without creating a directory"
      cp -f $tempLocation/$file $targetMkDocsLocation
    else
      echo "Path Depth => 1. Creating file and directory"
      newFile=$(printf '%s' "$file" | sed 's/[_]//g' | sed -e 's/\b\(.\)/\u\1/g')
      newFilePath="${newFile%/*}/"
      newFilePath=$(echo $newFilePath | sed 's/\/*$//g')
      if [[ "$newFilePath" =~ '/' ]]; then
        echo "Creating directory $newFilePath"
        mkdir -p $(dirname $targetMkDocsLocation/$newFilePath)
      fi
      if [[ "$file" =~ 'README.md' ]] && [[ $PATH_DEPTH > 2 ]]; then
        cp -f $tempLocation/$file $targetMkDocsLocation/$newFilePath".md"
      else
        cp -f $tempLocation/$file $(dirname $targetMkDocsLocation/$newFilePath)
      fi
    fi
  fi
done

rm -rf $tempLocation
