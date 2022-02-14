#!/usr/bin/bash
listdbs() {
echo -e "=================="
echo -e "=   DataBases    ="
echo -e "=================="
    for db in `ls $PWD/"databases"`
    do
    echo -e "\t$db"
    done
echo -e "=================="
echo "Press any key to get back to main menu"
read key
clear
 ./mainmenue.sh
}
