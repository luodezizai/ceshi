#!/bin/sh
if [[ $# -lt 1 ]]; then
  echo "Usage: "$0" <cid>"
  exit
fi
cid=$1
echo $#
echo '"sss"'${cid}'ccc'
