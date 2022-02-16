source ./connectdb.sh
 dropdb () {
listdb
    read -p "Enter DataBase Name you need to Delete or 1 to get back : " db_Name
    
    if [ $db_Name == '1' ]
    	then 
    	    clear
    source	./mainmenue.sh
    elif [ ! "$db_Name" == '' ]
        then
		 if [ -d ./databases/$db_Name ]
		then
		    rm -r ./databases/$db_Name/
		  
		    echo -e "\n\t DataBase Deleted Successfully \n "
		    clear
		    
		else
		clear
		    echo -e "\n\t No Such Name For DataBase "
		    echo -e "\t Please enter The Correct Name  \n"  
		dropdb
		fi
        else
        clear
        echo -e "\n\t Please enter valid data \n"
        dropdb
        fi    
       

echo -e "*==== Do you want Delete another Database  ====*"
select choice in 'Yes' 'No'
do
case $REPLY in 
    1) dropdb
    ;;
    2) clear 
   source ./mainmenue.sh
    ;;
    *) echo " $REPLY is Not One Of the choices"  
    ;;
esac
done
}


