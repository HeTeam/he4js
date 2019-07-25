#!/bin/bash

# Base64 encode all PNG files into a JSON file in the current directory
# Written by: Matt Wiggins, Updated 06-24-2013
# 修改：poerlang

json="otherbin={\n"
for file in *.sk
do
  current="$(openssl base64 -in $file)"
  json+="\t\"res/${file}\":\"$current\",\n"
done

json+="}"

echo -e $json > $1