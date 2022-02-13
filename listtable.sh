source ./connectdb.sh


#!/usr/bin/bash
listtable() {
echo -e "=================="
echo -e "=   Tables In $db_name   ="
echo -e "=================="
    for tb in `ls $PWD/"databases"/$db_name`
    do
    echo -e "\t$tb"
    done
echo -e "=================="
echo "Press any key to get back to main menu"
read key
source ./tablesmenu.sh
}
