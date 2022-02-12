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
    read -p "Enter database name : " dbName
        if [ "$dbName" == '' ]
        then
            echo  "*======Please Enter Valid Data======*"
          continue  
        elif  [[ $dbName =~  ^[0-9]+$ ]] 
        then
             echo  "*======DataBaseName Cant Consist of numbers only======*"
         continue
        elif [ -d ./databases/$dbName ]
        then
            echo -e "*======DataBaseName already Exist======*"
        else
            mkdir ./databases/$dbName
            echo ""
            echo  -e "\t Database  $dbName succesfully created"
            echo ""
            clear
            break
        fi
done
echo  "*=========Do You Need To Create More DataBases==========*"

     select type in 'Yes' 'No'
     do 
        case $REPLY in
           
           1) ./createdb
            ;;   
            
           2) clear
            ./mainmenue.sh
            ;;
       
    esac
    done
}

