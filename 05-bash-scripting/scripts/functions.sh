#! /bin/bash

checkdirectory(){
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
}

create_backup_directory(){
        if [ -d "/backup" ]; then
        echo "directory exists."
else
        echo "Directory does not exists"
        cd /home/"$USER"
        mkdir backup
        echo "Created the backup directory inside the home directory"
fi
}

log_message(){
        journalctl -n 50

}

main(){
        checkdirectory
        create_backup_directory
        log_message
}


main