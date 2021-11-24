//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_LONGINT:C283($temp)
C_COLLECTION:C1488($MyColl; $result)
C_OBJECT:C1216($variable)
C_REAL:C285($pas)

// Get all commands from the current 4D Version

$Listbox_Name:="LB_Information"
LB_Init_Start($Listbox_Name)

$mycoll:=Storage:C1525.symbols_variable.query("name != :1"; "$@")
$result:=New collection:C1472
C_LONGINT:C283($window)
C_OBJECT:C1216($param)
$param:=New object:C1471("title"; "Count variables."; "icon"; "icns_structure.png"; "type"; 0)
QST_progress_start($param)
$window:=$param.window

$pas:=1/($MyColl.length+1)
$progression:=0
$param.content:="Check in progress..."
$j:=0

For each ($variable; $MyColl)
	$j:=$j+1
	$temp:=Storage:C1525.allMethods.countValues("@"+$variable.name+"@"; "code")
	$result.push(New object:C1471("method"; $variable.name; "# calls"; $temp; "empty"; ""))
	If ($j%10=0)
		$progression:=$progression+(10*$pas)
		$param.value:=$progression
		CALL FORM:C1391($window; "progressBar_update"; $param)
		PROCESS_sleep
	End if 
	
End for each 


If ($result.length>0)
	LB_buildByCollection($result; $Listbox_Name)
	
	Form:C1466.result:=$result.copy()
	ARRAY TEXT:C222($tabPropertyNames; 0x0000)
	OB GET PROPERTY NAMES:C1232($result[0]; $tabPropertyNames)
	
	For ($i; 1; Size of array:C274($tabPropertyNames))
		
		Case of 
			: ($i=1)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Variable Name")
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 300)
				
		End case 
		
	End for 
	
	LB_BlockEvents($Listbox_Name)
	$FenetreInformation:=String:C10(Form:C1466.result.length)+" variables process / inter process found."
	$color:="red"
	
Else 
	$FenetreInformation:="No variable process / inter process found."
	$color:="green"
End if 

displayInfo($FenetreInformation; $color)
KILL WORKER:C1390("QST_Progress")