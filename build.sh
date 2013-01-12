#!/bin/bash

if [ "$USER" != "jenkins" ]
then
  exit 1
fi

tidy -modify -indent -f index_htmlErrors.txt index.html;
if [[ "$?" -gt 1 ]]
then
  exit 2
fi

set -e


stat=`git status --porcelain`
stlen=${#stat}
if [[ "$stlen" -gt 0 ]]
then
  git add index_htmlErrors.txt index.html
  git commit -m "Jenkins"
  git checkout master
  git merge HEAD@{1}
  git push
  git push origin master:gh-pages
fi
