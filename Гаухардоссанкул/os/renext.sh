#!/bin/bash
echo $1
echo $2
for f in *.$1;
do
mv "$f" "${f%.$1}$2"
done