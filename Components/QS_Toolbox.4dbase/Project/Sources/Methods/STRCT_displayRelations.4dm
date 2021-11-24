//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // https://blog.4d.com/detailed-analysis-database-structure/

C_OBJECT:C1216($oTable;$1)
C_LONGINT:C283($i;$size)

$oTable:=$1

  //$Listbox_Name:="ExploreStructure"
  //If (OB Is defined($oTable;"color")=True)
  //$otmp:=$oTable.color
  //$color:=(Num($otmp.red) << 16)+(Num($otmp.green) << 8)+Num($otmp.blue)
  //OBJECT SET RGB COLORS(*;$Listbox_Name;0;$color)
  //Else 
  //OBJECT SET RGB COLORS(*;$Listbox_Name;0;0x00FFFFFF)
  //End if 

$p_Relation_name_Nto1:=OBJECT Get pointer:C1124(Object named:K67:5;"Relation_name_Nto1")
$p_Relation_name_1toN:=OBJECT Get pointer:C1124(Object named:K67:5;"Relation_name_1toN")
$p_Relation_uuid:=OBJECT Get pointer:C1124(Object named:K67:5;"Relation_uuid")
$p_Relation_integrity:=OBJECT Get pointer:C1124(Object named:K67:5;"Relation_integrity")
$p_Relation_choice_field:=OBJECT Get pointer:C1124(Object named:K67:5;"Relation_choice_field")
$p_Relation_auto_load_Nto1:=OBJECT Get pointer:C1124(Object named:K67:5;"Relation_auto_load_Nto1")
$p_Relation_auto_load_1toN:=OBJECT Get pointer:C1124(Object named:K67:5;"Relation_auto_load_1toN")
$p_Relation_entry_wildchar:=OBJECT Get pointer:C1124(Object named:K67:5;"Relation_entry_wildchar")
$p_Relation_entry_create:=OBJECT Get pointer:C1124(Object named:K67:5;"Relation_entry_create")
$p_Relation_entry_autofill:=OBJECT Get pointer:C1124(Object named:K67:5;"Relation_entry_autofill")

$p_Relation_name_Nto1->:=$oTable.name_Nto1
$p_Relation_name_1toN->:=$oTable.name_1toN
$p_Relation_uuid->:=$oTable.uuid

If (OB Is defined:C1231($oTable;"integrity")=True:C214)
	$p_Relation_integrity->:=$oTable.integrity
Else 
	$p_Relation_integrity->:="None"
End if 

$p_Relation_choice_field->:=$oTable.choice_field

$Tmp:=$oTable.auto_load_Nto1
$p_Relation_auto_load_Nto1->:=Choose:C955((($Tmp="") | ($Tmp="False"));0;1)

$Tmp:=$oTable.auto_load_1toN
$p_Relation_auto_load_1toN->:=Choose:C955((($Tmp="") | ($Tmp="False"));0;1)

$Tmp:=$oTable.entry_wildchar
$p_Relation_entry_wildchar->:=Choose:C955((($Tmp="") | ($Tmp="False"));0;1)

$Tmp:=$oTable.entry_create
$p_Relation_entry_create->:=Choose:C955((($Tmp="") | ($Tmp="False"));0;1)

$Tmp:=$oTable.entry_autofill
$p_Relation_entry_autofill->:=Choose:C955((($Tmp="") | ($Tmp="False"));0;1)

ARRAY OBJECT:C1221($arrField;0)
OB GET ARRAY:C1229($oTable;"related_field";$arrField)

$size:=Size of array:C274($arrField)

$p_Relation_kind:=OBJECT Get pointer:C1124(Object named:K67:5;"Relation_kind")
$p_Relation_field_name:=OBJECT Get pointer:C1124(Object named:K67:5;"Relation_field_name")
$p_Relation_field_uuid:=OBJECT Get pointer:C1124(Object named:K67:5;"Relation_field_uuid")
$p_Relation_Table_name:=OBJECT Get pointer:C1124(Object named:K67:5;"Relation_Table_name")
$p_Relation_Table_uuid:=OBJECT Get pointer:C1124(Object named:K67:5;"Relation_Table_uuid")

ARRAY TEXT:C222($p_Relation_kind->;$size)
ARRAY TEXT:C222($p_Relation_field_name->;$size)
  //ARRAY TEXT($p_Relation_field_uuid->;$size)
ARRAY TEXT:C222($p_Relation_Table_name->;$size)
  //ARRAY TEXT($p_Relation_Table_uuid->;$size)

For ($i;1;$size)
	$p_Relation_kind->{$i}:=$arrField{$i}.kind
	$p_Relation_field_name->{$i}:=$arrField{$i}.name
	  // $p_Relation_field_uuid->{$i}:=$arrField{$i}.uuid
	$p_Relation_Table_name->{$i}:=$arrField{$i}.table_name
	  //$p_Relation_Table_uuid->{$i}:=$arrField{$i}.table_uuid
End for 