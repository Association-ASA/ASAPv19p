C_POINTER:C301($valPtr;$togPtr;$fieldPtr)
C_TEXT:C284($container;$button;$val)
C_LONGINT:C283($pos)
C_BOOLEAN:C305($field)

  //--------- Modify variables here --------------//
C_OBJECT:C1216(togObj1)
$togPtr:=->togObj1  //<-- Modify process variable here so they are unique, (ex: togObj->togObj1)
$field:=Form:C1466.tableProperties
$fieldPtr:=->$field  //<-- Change to ptr of field
  //$fieldPtr:=->tableProperties  //<-- Change to ptr of field
$container:="container1"  //<-- Change to name of container picture var
$val:="val1"  //<-- Change to name of value variable
  //----------------------------------------------//

$button:=OBJECT Get name:C1087(Object current:K67:2)
$valPtr:=OBJECT Get pointer:C1124(Object named:K67:5;$val)

TOG_Handler ($togPtr;$button;$container;$fieldPtr;$val;Current method path:C1201)
TOGOBJ_GET_VAL ($togPtr->;"Position";->$pos)


