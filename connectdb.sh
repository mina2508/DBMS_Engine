#!/usr/bin/bash

listdb(){

echo -e "=================="
	echo -e " =  Existed DataBases  ="
	echo -e " =================="
    for db in `ls $PWD/"databases"`
    do
    echo -e "\t $db "
    done
    echo -e " ================== \n"
}

 connect () {
 listdb
    read -p "Please Enter DB Name You Need To Connect : " db_name
        if [ -d ./databases/$db_name ] && [ "$db_name" != '' ]
        then 
        clear
          
            echo -e "\n\t*========= Connected To $db_name  ============*\n"
          export db_name
            ./tablesmenu.sh
        else 
            echo -e "\n\t No Such DataBase"
            echo -e "\tTry Again Please  \n"
            connect
        fi
}




