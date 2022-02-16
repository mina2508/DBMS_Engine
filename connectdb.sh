#!/usr/bin/bash

listdb(){

if [ -d $PWD/"databases" ]
then
echo -e "=================="
echo -e "=   Existed DataBases    ="
echo -e "=================="
    for db in `ls $PWD/"databases"`
    do
    echo -e "\t$db"
    done
echo -e "=================="
else
echo -e "============================"
echo -e "=    Existed DataBases    ="
echo -e "============================"
echo -e "=   No DataBases to be connect    ="
echo -e "============================"

fi
}

 connect () {
 listdb
    read -p "Please Enter DB Name You Need To Connect or 1 to get back : " db_name
    	if [ $db_name == '1' ]
    	then 
    		clear
    		source	./mainmenue.sh
        elif [ -d ./databases/$db_name ] && [ "$db_name" != '' ]
        then 
        clear
          
            echo -e "\n\t*========= Connected To $db_name  ============*\n"
          export db_name
          source  ./tablesmenu.sh
        else 
        clear
            echo -e "\n\t No Such DataBase"
            echo -e "\tTry Again Please  \n"
            connect
        fi
}




