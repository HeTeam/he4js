#!/bin/bash

# Base64 encode all PNG files into a JSON file in the current directory
# Written by: Matt Wiggins, Updated 06-24-2013
# 修改：poerlang

json="imgsData={\n"
for file in *.png
do
  current="$(openssl base64 -in $file)"
  json+="\t\"res/${file}\":\"data:image/png;base64,$current\",\n"
done

json+="}"

echo -e $json > $1