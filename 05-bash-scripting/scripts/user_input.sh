#! /bin/bash
echo What is your name ?
read NAME
echo Which directory should I backup ?
read BAK_DIR
echo What should be the number of days the backup nedd to be kept ?
read NUM_BAK

echo The name is $NAME
echo The directory to  backup is : $BAK_DIR
echo The backup should be kept for $NUM_BAK days