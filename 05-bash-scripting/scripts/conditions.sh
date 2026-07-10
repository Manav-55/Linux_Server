#! /bin/bash

read -p "Enter the directory : " DIR
if [ -d "/$DIR" ]; then
        echo "directory exists."
else
        echo "Directory does not exists"
        read -p "Create it? (y/n) : " CHOICE
        if [ $CHOICE == y ];then
                mkdir $DIR
                echo "Directory created"
        elif [ $CHOICE == n ];then
                echo "okkk"
        else
                echo "Enter the right value"
        fi
fi