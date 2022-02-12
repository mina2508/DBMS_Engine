#!/usr/bin/bash

source ./listdb.sh
source ./createdb.sh
source ./connectdb.sh
source ./dropdb.sh

PS3="Enter your choice : "
select choice in "Create Database" "List Databases"  "Connect To Databases" "Drop Database"
do
case $REPLY in
1) createdb
;;
2) listdbs
;;
3) clear
   connect
;;
4) dropdb
;;
*) echo $REPLY "is not one of the choices."
;;
esac
done
