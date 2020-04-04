#!/bin/bash
while IFS= read LINE || [[ -n "$LINE" ]]
    do  mkdir $LINE
done < E:/dir.tx
