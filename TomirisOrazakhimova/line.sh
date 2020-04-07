#!/bin/bash
while IFS= read USER || [[ -n "$USER" ]]
    do mkdir "$USER"
done < list.txt


