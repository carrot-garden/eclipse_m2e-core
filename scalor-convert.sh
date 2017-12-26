#!/bin/bash

# this folder
base=${BASH_SOURCE%/*}

repo="$base/scalor"
echo "### using scalor repository: $repo"

path="org/eclipse/m2e"

side="$repo/$path"
echo "### using repository folder: $side"

snap="1.8.1-SNAPSHOT"
vers="1.8.1"

echo "### remove repositories files"
find "$side" -type f -name '*.repositories' |
   xargs rm

echo "### rename maven-metadata files"
find "$side" -type f -name 'maven-metadata-local.xml' |
   sed -e "p;s|maven-metadata-local.xml|maven-metadata.xml|" | 
   xargs -n2 mv

echo "### rename snap dirs"
find "$side" -type d -name $snap |
   sed -e "p;s|$snap|$vers|" | 
   xargs -n2 mv

echo "### rename snap files"
find "$side" -type f -name "*$snap.pom" -o -name "*$snap.jar" -o -name "*$snap-sources.jar" | 
   sed -e "p;s|$snap|$vers|" | 
   xargs -n2 mv

echo "### remove remaining snap files"
find "$side" -type f -name "*${snap}*" |
   xargs rm

looking="<version>$snap</version>"
replace="<version>$vers</version>"

echo "### rename snap xml content"
find "$side" -type f -name "*${vers}.pom" -o -name "maven-metadata.xml" |
   xargs sed -i "s|$looking|$replace|"
