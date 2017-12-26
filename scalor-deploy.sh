#!/bin/bash -e

# this folder
base=${BASH_SOURCE%/*}

mvn deploy -f "$base"/pom.scalor.xml -B
