//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
//----------------------------------------------------
// User name(OS) Johan B
// Date and time 18-03-23, 153457
//----------------------------------------------------
// Method Dev_OpenAForm(formtext{;tableptr})
// Description
// Special Thanks to Johan BRAUN
//
// Parameters
//----------------------------------------------------
// http://forums.4d.com/Post/FR/23408298/1/23408299#23408299

C_POINTER:C301($2; $theTable)
C_TEXT:C284($1; $theFOrm)

ASSERT:C1129(Count parameters:C259>=1; "Need at least 1 parameter")
ASSERT:C1129(Count parameters:C259<=2; "Need max 2 parameters")
ASSERT:C1129(Type:C295($1)=Is text:K8:3; "Param $1 must be a text type")

$theForm:=$1

If (Count parameters:C259=2)
	ASSERT:C1129(Type:C295($2)=Is pointer:K8:14; "Param $2 must be a pointer type")
	$theTable:=$2
End if 

$dp:=GetDesignProcess
PROCESS_sleep(5)

ARRAY LONGINT:C221($arWindows; 0x0000)
WINDOW LIST:C442($arWindows)
$i:=1
$len:=Size of array:C274($arWindows)
$foundWindow:=0

If ($len>0)
	
	Repeat 
		$Title:=Get window title:C450($arWindows{$i})
		
		If ($Title="@ - Explorer") | ($Title="@ - Explorateur")
			$foundWindow:=$arWindows{$i}
		End if 
		
		$i:=$i+1
		
	Until ($i>$len) | ($foundWindow#0)
End if 

If ($foundWindow#0)
	BRING TO FRONT:C326($dP)
	SHOW WINDOW:C435($foundWindow)
	//POST KEY(Character code("W");Command key mask;$dP)
	//PROCESS_sleep (15)
	
End if 

BRING TO FRONT:C326($dP)
PROCESS_sleep(15)

POST KEY:C465(Character code:C91("E"); Command key mask:K16:1+Option key mask:K16:7+Shift key mask:K16:3; $dP)
PROCESS_sleep(15)

POST CLICK:C466(40; 120; $dp)
PROCESS_sleep(5)
POST CLICK:C466(120; 30; $dp)

If (Not:C34(Is nil pointer:C315($theTable)))
	//POST KEY(Character code("T");0;$dP)
	
	POST KEY:C465(Down arrow key:K12:19; 0; $dp)
	PROCESS_sleep(5)
	POST KEY:C465(Right arrow key:K12:17; 0; $dp)
	PROCESS_sleep(5)
	
	$tableName:=Table name:C256($theTable)
	
	For ($i; 1; Length:C16($tableName))
		POST KEY:C465(Character code:C91($tableName[[$i]]))
	End for 
	
End if 

POST KEY:C465(Right arrow key:K12:17; 0; $dp)
PROCESS_sleep(5)

For ($i; 1; Length:C16($theFOrm))
	
	POST KEY:C465(Character code:C91($theFOrm[[$i]]))
	
End for 

POST KEY:C465(Enter key:K12:26; $dp)