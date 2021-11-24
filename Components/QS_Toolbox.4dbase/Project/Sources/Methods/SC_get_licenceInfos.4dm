//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 21/04/18, 16:05:35
// ----------------------------------------------------
// Méthode : SC_get_licenceInfos
// Description
//  
//
// Paramètres
// ----------------------------------------------------


C_OBJECT:C1216($LicenceInfo)
C_TEXT:C284($langage)
C_COLLECTION:C1488($result)

$Listbox_Name:="LB_Information"
LB_Init_Start($Listbox_Name)

$result:=New collection:C1472

$langage:=Config_getLanguage
$LicenceInfo:=Get license info:C1489

$txt:=String:C10($LicenceInfo.name)+" ("+String:C10($LicenceInfo.licenseNumber)+")"
ARRAY TEXT:C222($attributes; 0x0000)
OB GET ARRAY:C1229($LicenceInfo; "platforms"; $attributes)
For ($n; 1; Size of array:C274($attributes))
	$txt:=$txt+" - "+$attributes{$n}
End for 

$txt:=$txt+"\nto: "+String:C10($LicenceInfo.userName)+"("+String:C10($LicenceInfo.userMail)+" - "+String:C10($LicenceInfo.companyName)
$result.push(New object:C1471("method"; "name"; "current value"; $txt))

// Display now information about product licences
ARRAY OBJECT:C1221($products; 0x0000)
OB GET ARRAY:C1229($LicenceInfo; "products"; $products)

$result.push(New object:C1471("method"; "Product list "; "current value"; ""))

For ($n; 1; Size of array:C274($products))
	$result.push(New object:C1471("method"; ""; "current value"; $products{$n}.name))
End for 

If ($result.length>0)
	LB_buildByCollection($result; $Listbox_Name)
	
	Form:C1466.result:=$result.copy()
	ARRAY TEXT:C222($tabPropertyNames; 0x0000)
	OB GET PROPERTY NAMES:C1232($result[0]; $tabPropertyNames)
	
	For ($i; 1; Size of array:C274($tabPropertyNames))
		
		Case of 
			: ($i=1)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Licence Information")
				
		End case 
	End for 
	
	LB_ResizeHeader(OBJECT Get pointer:C1124(Object named:K67:5; $Listbox_Name))
	LB_setHeights($Listbox_Name; 2; 2)
	LB_BlockEvents($Listbox_Name)
End if 
displayInfo("")