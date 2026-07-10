#! /bin/bash

path=("/etc" "/home" "var/log")

for item  in ${path[@]}; do
        echo "Checking $item"
done