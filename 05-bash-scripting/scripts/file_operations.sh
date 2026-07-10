#! /bin/bash
echo "Changing to home directory..."
cd "/home/$USER"

echo "Creating backup directory..."
mkdir -p backup

echo "Entering backup directory..."
cd backup

echo "Creating log file..."
touch sample.log

echo "Creating sample file..."
echo "This is a sample text" > sample.txt

echo "Copying sample.txt to popo.txt..."
cp sample.txt popo.txt

echo "Contents of popo.txt:"
cat popo.txt

echo "Renaming popo.txt to dopo.txt..."
mv popo.txt dopo.txt

echo "Listing files..."
ls -la

echo "Deleting dopo.txt..."
rm dopo.txt

echo "Lab completed successfully."