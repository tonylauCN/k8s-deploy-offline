#!/bin/bash

name=$1;
target=$2;

# name exist and target not exist
if [ -e "$name" -a ! -e "$target" ]
then
cp -p "$name" "$target"
echo " #>>> Back File:'$1' To: '$2'"
else
echo " #>>> Back File:'$2' Ready Exist."
fi
