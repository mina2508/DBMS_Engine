
./connectdb.sh
check_pk () {

value=`cut -f1 -d: ./databases/$db_name/$table_name/$table_name.data | grep -w $1`

if [[ $value == '' ]]
then
   return 1 ;
else
   return 0 ;
fi

}

listtabledata (){

  counter=0
            for arr in `cut -d: -f3 ./databases/$db_name/$table_name/$table_name.metadata`
            do
            ((counter=$counter+1))
            array[$counter]=$arr
            done
            echo -e "==============$1================"
            sed -n "s/ /\t/gp" <<<${array[@]}
            echo -e "=============================="
            sed -n "s/:/ \t/gp" ./databases/$db_name/$1/$1.data
            echo -e "============================\n"
}


deletedata (){
read -p "Enter Table Name To Delete from or Press 1 to Get Back  : " table_name

if [ $table_name ]
then
	if [ $table_name == '1' ]
	then
	clear
	source	./tablesmenu.sh
	elif [  -d ./databases/$db_name/$table_name ]
	then

	    pk=`grep -wi pk ./databases/$db_name/$table_name/$table_name.metadata | cut -f3 -d: `
		listtabledata $table_name
	    while [[ true ]]
	    do

		read -p "Enter pk To Delete Record Using Your Pk Press 1 to Get Back $pk : " deleted
		if [ $deleted == '1' ]
		then
			clear
			deletedata
		elif [ $deleted ]
		then 
		    if check_pk $deleted; then
		        sed -i  '/^'$deleted'/d' ./databases/$db_name/$table_name/$table_name.data
		        clear
		        echo -e "\n\t Record Deleted Sucssefully\n" 
		        break 
		    else
		    echo -e "\n\t PK not found"
		    continue
		    fi 
		    
		else
		echo -e "\n\t please enter pk"
		continue
		fi
		
	    done
	
	else 
	clear
	    echo -e "\n\t No Such Table "
	    echo -e "\n\t Please Try again "
	    deletedata
	fi
else
echo -e "\n\t enter valid data "
fi
            echo -e "=========Data After Deleteing==========="
        listtabledata $table_name
echo -e "*==== Do you want delete another record! ====*"
select type in 'Yes' 'No'
do
    case $REPLY in 
        1) clear 
        deletedata 
        ;;
        2) 
            break ;; 
        *) echo "$REPLY is not one of the choices";
        ;;
    esac
done
clear
source ./tablesmenu.sh
}
