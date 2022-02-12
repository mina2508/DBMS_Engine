


source ./connectdb.sh

pkcolumn () {
   read -p "Enter pk column name : " col_name
   if [[ ! $col_name == '' ]]
   then

       if [[ $col_name =~  ^[a-zA-Z]+[a-zA-Z0-9]*$ ]] 
       then
       		if [[  $col_name == $table_name ]] 
			then
          			echo -e "\n\t PK Column Name Cant Be The Same As TableName \n"
          		 pkcolumn
          		else	
                        select choice in " Press 1 for DataType Number : " " Press 2 for DataType String : "
                        do
                            case $REPLY in
                            1) echo $counter":""number"":"$col_name":pk" >> ./databases/$db_name/$table_name/$table_name".metadata"
                            break 1 ;;
                            2) echo $counter":""string"":"$col_name":pk" >> ./databases/$db_name/$table_name/$table_name".metadata"
                            break 1 ;;
                            *) echo $REPLY "is not one of the choices."
                            ;;
                            esac
                        done
                        fi
       else 
         echo -e "\n\t Enter Correct Format \n"
        pkcolumn
        fi
 
   else 
     echo -e "\n\t pk cannot be a null \n"
     pkcolumn
    fi
    
}



 check_column_name_exist () {
	isExist=$(awk -v colName="$col_name" -F: 'BEGIN{isExist=0} {if($3==colName) {isExist=1}} END{print isExist}' ./databases/$db_name/$table_name/$table_name".metadata");
	if [ $isExist -eq 1 ]; then
		return 1;
	else 
		return 0;
  fi
}

createcolumn () {
echo $table_name
read -p "Enter The Number Of Columns at least 2 column  : " col_number
let counter=1


if [[ $col_number =~ ^[2-9]+$ ]]
then


  while [ $col_number -ge $counter ]
  do

        if [[ $counter == 1 ]]
        then
          clear
          pkcolumn 
          ((counter = $counter+1))
        fi
        read -p "Enter Your Column name  $counter : " col_name
	if [[  $col_name == $table_name ]] 
	then
          echo -e "\n\t Column Name Cant Be The Same As TableName \n"
          continue
          
        elif [[ $col_name =~  ^[a-zA-Z]+[a-zA-Z0-9]*$ ]] && [[ ! $col_name == '' ]] 
        then
        
                  

                if check_column_name_exist; then
                    

                      
                        select choice in " Press 1 for DataType Number : " " Press 2 for DataType String : "
                        do
                            case $REPLY in
                            1) echo $counter":""number"":"$col_name >> ./databases/$db_name/$table_name/$table_name".metadata"
                            ((counter = $counter+1))
                            break 1 ;;
                            2) echo $counter":""string"":"$col_name >> ./databases/$db_name/$table_name/$table_name".metadata"
                            ((counter = $counter+1))
                            break 1 ;;
                            *) echo $REPLY "is not one of the choices."
                            ;;
                            esac
                        done
            
                echo -e "\n\t Column Name repeated \n"
                fi    
                
        else 
        echo -e "\n\t Please Enter Valid Name \n"
        continue
        fi

    done
else 
echo -e "\n\t Enter Valid Number \n"
createcolumn

fi
}





createtable () {

    read -p "Enter Your Table Name : " table_name
    if [[ $table_name =~  ^[a-zA-Z]+[a-zA-Z0-9]*$ ]] && [[ ! $table_name == '' ]]
    then
        if [ ! -d ./databases/$db_name/$table_name ]
        then
		if [[  $table_name == $db_name ]] 
		then
		  echo -e "\n\t TableName Cant Be The Same As DataBaseName \n"
		  createtable
      	        else
		mkdir ./databases/$db_name/$table_name
		touch ./databases/$db_name/$table_name/$table_name".data"
		touch ./databases/$db_name/$table_name/$table_name".metadata"
		createcolumn 
		clear
		echo -e "\n\t Table Created Successfully\n"
		
		    echo -e "*================ Do you want to Create more tables  ==============*\n"
		          select type in 'Yes' 'No'
		          do
		              case $REPLY in 
		                  1)
		                      createtable
		                      ;;
		                  2)   
		                    clear
		                      break ;; 
		                  *) echo -e "*====\n\t please enter right choice \n====*";
		                  
		              esac
		          done
		./tablesmenu.sh
		fi	
        else 
        echo -e "\n\t*========Table Already Exists========*"
        echo -e "\t*========Please Try again========*\n"
        createtable
        fi
    else
      echo -e "\n*========Invalid Name For Table========*\n"
      createtable
fi
       
}









