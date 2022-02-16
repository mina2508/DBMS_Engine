#!/usr/bin/bash
listdbs() {
if [ -d $PWD/"databases" ]
then
echo -e "=================="
echo -e "=   DataBases    ="
echo -e "=================="
    for db in `ls $PWD/"databases"`
    do
    echo -e "\t$db"
    done
echo -e "=================="
else
echo -e "============================"
echo -e "=   No Existed DataBases    ="
echo -e "============================"
fi
echo "Press any Enter to get back to main menu"
read key
clear
source  ./mainmenue.sh
}
