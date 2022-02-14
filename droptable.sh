source ./connectdb.sh
listExistedtable() {
echo -e "=================="
echo -e "=  Existed Tables In $db_name   ="
echo -e "=================="
    for tb in `ls $PWD/"databases"/$db_name`
    do
    echo -e "\t $tb"
    done
echo -e "=================="

}
 droptable () {

 listExistedtable

    read -p "Enter Table Name you need to Delete : " table_Name
    if [ ! "$table_Name" == '' ]
        then

		 if [ -d ./databases/$db_name/$table_Name  ]
		then
		    rm -r ./databases/$db_name/$table_Name
		  
		    echo -e "\n\t Table Deleted Successfully \n "
		    clear
		    
		else
		    echo -e "\n\t No Such Name For Table "
		    echo -e "\t Please enter The Correct Name  \n"  
		droptable
		fi
        else
        echo -e "\n\t Please enter valid data \n"
        dropdb
        fi    
       

echo -e "*==== Do you want to Delete another Table  ====*"
select choice in 'Yes' 'No'
do
case $REPLY in 
    1) droptable
    ;;
    2) clear 
    ./tablesmenu.sh
    ;;
    *) echo " $REPLY is Not One Of the choices"  
    ;;
esac
done
}

