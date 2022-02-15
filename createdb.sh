#!/usr/bin/bash
createdb(){
    if [ ! -d ./databases/ ]
    then
    mkdir ./databases
    fi
    echo  "=========================================="
    echo  "#           create Database             #"
    echo  "=========================================="
while [[ true ]]
do
    read -p "Enter database name or press 1 To get back : " dbName
    	if [ "$dbName" == '1' ]
    	then
    		clear
    	   ./mainmenue.sh
        elif [ "$dbName" == '' ]
        then
        	clear
            echo  "*======Please Enter Valid Data======*"
          continue  
        elif  [[ $dbName =~  ^[0-9]+$ ]] 
        then
        	clear
             echo  "*======DataBaseName Cant Consist of numbers only======*"
         continue
        elif [ -d ./databases/$dbName ]
        then
            echo -e "*======DataBaseName already Exist======*"
        elif [[ "$dbName" =~  ^[a-zA-Z]+[a-zA-Z0-9]*$ ]]
        	then 
            mkdir ./databases/$dbName
            echo ""
            echo  -e "\t Database  $dbName succesfully created"
            echo ""
            clear
            break
            
         else
         clear
            echo  -e "\t cant enter special characyters as DataBase Name"
         
        fi
done
echo  "*=========Do You Need To Create More DataBases==========*"

     select type in 'Yes' 'No'
     do 
        case $REPLY in
           
           1)clear
           createdb
            ;;   
            
           2) clear
            ./mainmenue.sh
            ;;
       
    esac
    done
}

