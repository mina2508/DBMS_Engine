#!/usr/bin/bash

source ./listdb.sh
source ./createdb.sh
source ./connectdb.sh
source ./dropdb.sh

PS3="Enter your choice : "
select choice in "Create Database" "List Databases"  "Connect To Databases" "Drop Database" "Exit"
do
case $REPLY in
1)clear 
createdb
;;
2)clear 
listdbs
;;
3) clear
   connect
;;
4)clear 
dropdb
;;
5)
clear 
exit
;;
*) echo $REPLY "is not one of the choices."
;;
esac
done
