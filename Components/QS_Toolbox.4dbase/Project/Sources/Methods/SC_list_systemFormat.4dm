//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_TEXT:C284($vSepDate; $vSepDec; $vSepHeure; $vSepMilliers; $vSymbMon)
C_COLLECTION:C1488($result)
$Listbox_Name:="LB_Information"
LB_Init_Start($Listbox_Name)

$result:=New collection:C1472

GET SYSTEM FORMAT:C994(Currency symbol:K60:3; $vSymbMon)
GET SYSTEM FORMAT:C994(Decimal separator:K60:1; $vSepDec)
GET SYSTEM FORMAT:C994(Time separator:K60:11; $vSepHeure)
GET SYSTEM FORMAT:C994(Thousand separator:K60:2; $vSepMilliers)
GET SYSTEM FORMAT:C994(Date separator:K60:10; $vSepDate)

$result.push(New object:C1471("method"; "Money Symbole"; "value"; $vSymbMon; "empty"; ""))
$result.push(New object:C1471("method"; "Thousands separator"; "value"; $vSepMilliers; "empty"; ""))
$result.push(New object:C1471("method"; "Decimal separator"; "value"; $vSepDec; "empty"; ""))
$result.push(New object:C1471("method"; "Time separator"; "value"; $vSepHeure; "empty"; ""))
$result.push(New object:C1471("method"; "Date separator"; "value"; $vSepDate; "empty"; ""))

If ($result.length>0)
	LB_buildByCollection($result; $Listbox_Name)
	
	Form:C1466.result:=$result.copy().orderBy("method")
	ARRAY TEXT:C222($tabPropertyNames; 0x0000)
	OB GET PROPERTY NAMES:C1232($result[0]; $tabPropertyNames)
	
	For ($i; 1; Size of array:C274($tabPropertyNames))
		
		Case of 
			: ($i=1)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 250)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Description")
				
			: ($i=2)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 170)
				
			: ($i=3)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "")
				
		End case 
	End for 
	
	LB_setHeights($Listbox_Name; 1; 2)
	LB_ResizeLine($Listbox_Name)
End if 