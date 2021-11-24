//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// nom utilisateur (OS) : sieste68
// date et heure : 08/10/19, 10:55:22
// ----------------------------------------------------
// méthode : FORM_LH_getDataSource
// description: Method will determine the data source of the Listbox
//
// parameters:
// $1 (TEXT) - Listbox name
//
// output:
// $0 (TEXT) - arrays, currentSelection, namedSelection,
// , collection, or (blank) for no type
// -----------------------------------------------------------
//  https://kb.4d.com/assetid=78073

C_TEXT:C284($2; $lbName)
C_TEXT:C284($0; $value)
C_OBJECT:C1216($formObj; $elem; $1)
C_COLLECTION:C1488($col)

$value:=""
$lbName:=$2

$formObj:=($1)
$col:=$formObj.pages
If ($col.length>0)
	
	For each ($elem; $col)
		If ($elem#Null:C1517)
			If (OB Is defined:C1231($elem.objects; $lbName)=True:C214)
				If (OB Is defined:C1231($elem.objects[$lbName]; "listboxType")=False:C215)
					$value:="Type arrays"
				Else 
					$value:="Type "+$elem.objects[$lbName].listboxType
				End if 
			End if 
		End if 
	End for each 
End if 

$0:=$value
