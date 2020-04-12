#!/bin/bash
while IFS= read LINE || [[ -n "$LINE" ]]
    do  mkdir "$LINE"
done < dir.txt
