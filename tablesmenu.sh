
source ./createtable.sh
source ./droptable.sh
source ./listtable.sh
source ./insertdata.sh
source ./selectdata.sh
source ./deletedata.sh


 
PS3="Enter your choice : "
select choice in "Create Table" "List Tables"  "Drop Table" "Insert into Table" "Select From Table" "Delete From Table"  "back" 
do
case $REPLY in
1)
 clear
 createtable
;;
2)
 clear
 listtable
;;
3)
 clear
 droptable
;;
4)
 clear 
 insert
;;
5) 
 clear
 selectdata
;;
6)
 clear 
 deletedata
;;
7)
clear
./mainmenue.sh
;;
*) echo $REPLY "is not one of the choices."
;;
esac
done
