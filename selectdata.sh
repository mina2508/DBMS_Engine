source ./connectdb.sh



select_column () {
   
  
            read -p "Enter column Name you want to select or Enter 1 to get back  : " col_header
          if [ $col_header == 1 ]
          then 
          clear 
          selectdata
            
            elif [ $col_header ]
            then
                   check_col_header=`grep -wi $col_header   ./databases/$db_name/$table_name/$table_name.metadata`
                   total_number_of_columns=`wc -l ./databases/$db_name/$table_name/$table_name.metadata`
                   if [ $check_col_header ]
                   then

                        retrive_number=`grep $col_header ./databases/$db_name/$table_name/$table_name.metadata  | awk -F: '{ print $1}'`
                        if [ $retrive_number ]
                        then
                        echo "Enter one value of any of this columns to display the whole record"
                                while [[ true ]]
                                do
                                    read display_data
                                    if [ $display_data == 1 ]
                                    then
                                    clear
                                    select_column
                                    elif [ $display_data ]
                                    then
                                        clear
                                        counter=0
				    for arr in `cut -d: -f3 ./databases/$db_name/$table_name/$table_name.metadata`
				    do
				    ((counter=$counter+1))
				    array[$counter]=$arr
				    done

				    sed -n "s/ /\t/gp" <<<${array[@]}
				    echo -e "============================"
  awk -F: -v name="$display_data" -v num="$retrive_number" '{i=1; while (i<num+1){if(i==num){if($i==name) {print $0;}};i++}}' ./databases/$db_name/$table_name/$table_name.data | sed -n "s/:/\t/gp"


                                        echo -e "============================"
                                        echo -e "*==== Do you want Select another record! ====*"
                                        select type in 'Yes' 'No'
                                            do
                                                case $REPLY in 
                                                    1) clear 
                                                    selectdata
                                                    ;;
                                                    2)clear
                                                    ./tablesmenu.sh 
                                                    ;; 
                                                    *) echo "$REPLY is not one of the choices";
                                                    ;;
                                                esac
                                            done 
                                    else
                                    echo -e "\n\t Please enter Valid data \n"
                                    fi
                                done
                        else
                        echo "*======please enter Valid Data =====*"
                        select_column
                        fi

                    else
                         echo -e "*=========== column name not found enter valid data ===========*\n"
                         select_column
                    fi 
            else
            echo -e "\n*=========column name not found enter valid data =========*\n"
            select_column
            fi
    # done

}




selectdata () {

read -p "Enter table name to select or 1 to get back : " table_name
if [ $table_name == '1' ]
then
clear
./tablesmenu.sh
elif [  -d ./databases/$db_name/$table_name ]  && [ "$table_name" != '' ]
then    

    
     select type in 'Select all table ' 'Select specfic Data' 'Back'
     do 
        case $REPLY in
           
           1)
            echo -e "===================="
            echo -e "===== Table: $table_name\t ==="
            echo -e "===================="
            counter=0
            for arr in `cut -d: -f3 ./databases/$db_name/$table_name/$table_name.metadata`
            do
            ((counter=$counter+1))
            array[$counter]=$arr
            done
            sed -n "s/ /\t/gp" <<<${array[@]}
            echo -e "===================="
            sed -n "s/:/\t/gp" ./databases/$db_name/$table_name/$table_name.data
            echo -e "==================\n"
            echo "Enter any key to back"
            read key
            clear
            break
            ;;   
           2)  select_column
            break 
            ;;
           3) clear  
           selectdata
            break 
            ;;
       
    esac
    done


else 
echo -e "*===== No Such Table========* "
echo -e "*=====Please Try again======* "
selectdata
fi

 ./tablesmenu.sh
}


