//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_LONGINT:C283($1;$list)

  // Assign the list reference to $list
$list:=$1

CLEAR LIST:C377(Form:C1466.my_LH)  // Remove, from memory, the my_LH list reference
Form:C1466.my_LH:=Copy list:C626($list)  // Assign to my_LH list a new reference number with the content of $list list
CLEAR LIST:C377($list)  // this is required if we won't create a memory leak

OBJECT SET LIST BY REFERENCE:C1266(*;"myLH";Choice list:K42:19;Form:C1466.my_LH)  // assign to the user interface object (widget myLH) the my_LH list
OBJECT SET ENTERABLE:C238(*;"myLH";False:C215)  // widget no editable 
SET LIST PROPERTIES:C387(Form:C1466.my_LH;0;0;15;1;0;1)  // obsolete;obsolete;size of a line;no double clic;no multi selection;editable