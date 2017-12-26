#!/bin/bash -e

# this folder
base=${BASH_SOURCE%/*}
cd "$base"

repo="$base/scalor"
echo "### using scalor repository: $repo"

path="org/eclipse/m2e"

side="$repo/$path"
echo "### removing repository artifacts: $side"
rm -r -f "$side"

maven_opts="\
-D skipTests \
-D maven.repo.local=$repo \
-B \
"

echo "### making runtime"
mvn clean install \
   -f m2e-maven-runtime/pom.xml \
   $maven_opts

echo "### making bundles"
mvn clean install \
   $maven_opts
