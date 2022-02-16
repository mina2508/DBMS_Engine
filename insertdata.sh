source ./connectdb.sh

read_meta_data () {
	 columnsNumber=$( cat ./databases/$db_name/$table_name/$table_name.metadata | wc -l )  

	columnsName=($(awk 'BEGIN{FS=":"}{if(NR>0)print $3;}' ./databases/$db_name/$table_name/$table_name.metadata))

	columnsTyps=($(awk 'BEGIN{FS=":"}{if(NR>0)print $2;}' ./databases/$db_name/$table_name/$table_name.metadata))
}


check_repeated_pk () {

reapted_value=`cut -f1 -d: ./databases/$db_name/$table_name/$table_name.data | grep -w $1`

if [[ $reapted_value == '' ]]
then
   return 0 ;
else
   return 1 ;
fi

}

check_type () {
	  
		
		case ${columnsTyps[$1]} in
			number) 
				if [[ $data =~ ^[1-9]+[0-9]*$ ]] ||  [[ $data == 0 ]]; then
					return 0;
				else
					echo -e "*== Can not Insert Characters into Number Type Column ==*"
					return 1;
				fi
				;;
			string)

				if [[ $data =~ ^[a-zA-Z]+[a-zA-Z0-9]*$ ]] || [[ $data =~ ^0[0-9]+$ ]]; then
					return 0;
				else
					echo -e "*== Can not Insert Number into String Type Column==*"
					return 1;
				fi
		esac

	}




read_col_data () {


	for (( i=0; i<$columnsNumber; i++ ))	
	do

				       
		if (( i == 0))
		then
		        while [[ true ]]
		        do
		                 echo -e "*====Enter  ${columnsName[i]} (PK) using dataType:${columnsTyps[i]} ====*";	
		            read  data;



		            if check_type $i; then
		            
				        if check_repeated_pk $data; then
				             record[$i]=$data
				             (( i++ ))
				            break ;
				        else
					     echo -e "*==== Sorry, this PK is used before ====*"
				            echo -e "*==== Use another PK ====*"
				          
				        fi                      
		            fi
		        done
               
        
		fi

		while [[ true ]]
			echo -e "*====Enter  ${columnsName[i]} using dataType:${columnsTyps[i]} ====*";
			do
				read data;
				 if check_type $i; then

					record[$i]=$data
					break ;
								
				fi
			done		
	
	

	done
 		
	echo ${record[*]} >> ./databases/$db_name/$table_name/$table_name."data"
	sed -i "s/ /:/g" ./databases/$db_name/$table_name/$table_name."data"
}






insert () {
echo "*==== Enter Table Name or 1 To Get Back ====*"
read table_name
  if [ $table_name == '1' ]
    then
    clear
   source ./tablesmenu.sh
elif [ -d ./databases/$db_name/$table_name ] && [ "$table_name" != '' ]
then
echo -e " \n \n \t*====inserting into table $table_name inside DataBas $db_name ====* \n \n"
	read_meta_data
   
                	echo "*==== Enter the record data ====*"
                	read_col_data		
					clear
                	echo -e "\n\t*==== Record inserted successfully ====*\n"
                	while [[ true ]]
                	do
                		echo -e "*==== Do you want to insert another record inside table $table_name ! ====*"
                		select type in 'Yes' 'No'
                		do
                			case $REPLY in 
                				1) clear
                				echo -e " \n \n \t*====inserting into table $table_name inside DataBas $db_name ====* \n \n"
                                   		 read_col_data	
							clear
                					echo -e "\n\t*==== Record inserted successfully ====*\n"
                					 break ;;
                				2) clear
                                  			 break 2 ;; 
                				*) echo "*==== Exit ====*";
                					break 2 ;;
                			esac
                		done
                	done	
else
	echo -e "\n\t *==== This table does not exist! ==== \n"
	echo -e "\t press any key to back..."	
	read key
	clear
	source ./tablesmenu.sh
fi
	source ./tablesmenu.sh
}
