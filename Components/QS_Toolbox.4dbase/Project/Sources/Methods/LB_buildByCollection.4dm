//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_COLLECTION:C1488($1;$result)
C_TEXT:C284($Listbox_Name;$2)
ARRAY TEXT:C222($tabPropertyNames;0x0000)
ARRAY LONGINT:C221($tabPropertyTypes;0x0000)

$result:=$1
$Listbox_Name:=$2

LB_Init_Start ($Listbox_Name)
Form:C1466.result.clear()
Form:C1466.result:=$result
OB GET PROPERTY NAMES:C1232($result[0];$tabPropertyNames;$tabPropertyTypes)

C_POINTER:C301($nil)
For ($i;1;Size of array:C274($tabPropertyNames))
	
	If ($tabPropertyTypes{$i}=42)  // Collection | Object
		$formula:="This[\""+$tabPropertyNames{$i}+"\"].join(\"; \")"
	Else 
		$formula:="This[\""+$tabPropertyNames{$i}+"\"]"
	End if 
	
	If (Substring:C12($tabPropertyNames{$i};1;2)="b_")
		$tabPropertyNames{$i}:=Substring:C12($tabPropertyNames{$i};3)
		LISTBOX INSERT COLUMN FORMULA:C970(*;$Listbox_Name;999;"QS_Col_"+$tabPropertyNames{$i};$formula;Is boolean:K8:9;"QS_header"+String:C10($i);$nil;"QS_footer"+String:C10($i);$nil)
	Else 
		LISTBOX INSERT COLUMN FORMULA:C970(*;$Listbox_Name;999;"QS_Col_"+$tabPropertyNames{$i};$formula;Is text:K8:3;"QS_header"+String:C10($i);$nil;"QS_footer"+String:C10($i);$nil)
	End if 
	
	OBJECT SET TITLE:C194(*;"QS_header"+String:C10($i);($tabPropertyNames{$i}))  // by default
	OBJECT SET ENTERABLE:C238(*;"QS_header"+String:C10($i);False:C215)
	OBJECT SET ENTERABLE:C238(*;"QS_Col_"+$tabPropertyNames{$i};False:C215)
End for 