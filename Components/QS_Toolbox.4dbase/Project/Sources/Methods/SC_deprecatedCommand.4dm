//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_LONGINT:C283($N)
C_TEXT:C284($method;$Language)
C_COLLECTION:C1488($MyColl;$result)
C_OBJECT:C1216($command)

  // Get all commands from the current 4D Version

$Listbox_Name:="LB_Information"
LB_Init_Start ($Listbox_Name)

$Language:=Config_getLanguage 
$MyColl:=New collection:C1472
$result:=New collection:C1472
$Listbox_Name:="LB_Information"

  // Keep only Deprecated commands
$MyColl:=Storage:C1525.commands4d.query($Language+" = :1 ";"_o_@")

For each ($command;$MyColl)
	
	If ($command.useIn.length>0)
		For each ($method;$command.useIn)
			$n:=$result.query("method = :1 and command = :2";$method;$command[$Language]).length
			If ($n=0)
				$result.push(New object:C1471("method";$method;"command";$command[$Language];"token";$command.token;"theme";$command.theme;"empty";""))
			End if 
		End for each 
	End if 
End for each 


If ($result.length>0)
	LB_buildByCollection ($result;$Listbox_Name)
	
	Form:C1466.result:=$result.copy()
	ARRAY TEXT:C222($tabPropertyNames;0x0000)
	OB GET PROPERTY NAMES:C1232($result[0];$tabPropertyNames)
	
	For ($i;1;Size of array:C274($tabPropertyNames))
		
		Case of 
			: ($i=1)
				OBJECT SET TITLE:C194(*;"QS_header"+String:C10($i);"Method Path Name")
				LISTBOX SET COLUMN WIDTH:C833(*;"QS_Col_"+$tabPropertyNames{$i};300)
				
			: ($i=2)
				OBJECT SET TITLE:C194(*;"QS_header"+String:C10($i);"Command Name")
				LISTBOX SET COLUMN WIDTH:C833(*;"QS_Col_"+$tabPropertyNames{$i};250)
				
			: ($i=3)
				OBJECT SET TITLE:C194(*;"QS_header"+String:C10($i);"Token")
				LISTBOX SET COLUMN WIDTH:C833(*;"QS_Col_"+$tabPropertyNames{$i};100)
				
			: ($i=4)
				OBJECT SET TITLE:C194(*;"QS_header"+String:C10($i);"Thema")
		End case 
		
	End for 
	
	ARRAY LONGINT:C221($MyEventsOnLB;2)
	$MyEventsOnLB{1}:=On Double Clicked:K2:5
	$MyEventsOnLB{2}:=On Clicked:K2:4
	OBJECT SET EVENTS:C1239(*;$Listbox_Name;$MyEventsOnLB;Enable events disable others:K42:37)
	
	$FenetreInformation:=String:C10(Form:C1466.result.length)+" deprecated commands found "
	$FenetreInformation:=$FenetreInformation+"\rDouble click to edit method."
	$color:="red"
	
Else 
	$FenetreInformation:="No deprecated command has been found."
	$color:="green"
End if 

displayInfo ($FenetreInformation;$color)