//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// -------------- Methods Analysis & SymbolFile Analysis --------------------

/* IMPORTANT NOTE:
All commands METHOD  GET xxxx are set here because they are NOT PREEMPTIVE
The idea is to have all in the same method and call a worker which the method used for this
is preemptive.
*/

ARRAY OBJECT:C1221($tbAttributes; 0x0000)
ARRAY TEXT:C222($tbPath; 0x0000)
ARRAY TEXT:C222($tabCodes; 0x0000)
ARRAY DATE:C224($tabDates; 0x0000)
ARRAY LONGINT:C221($tabHeures; 0x0000)
C_COLLECTION:C1488($data)
C_LONGINT:C283($tbPathLength)
C_OBJECT:C1216($newSignal; $declaration; $1; $method)
C_BOOLEAN:C305($LV_mode)

$onErrCallMethod:=Method called on error:C704
ON ERR CALL:C155("Base_NoError")

$declaration:=$1
$data:=New collection:C1472
If (Bool:C1537(Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_4DVersionR)=True:C214) & (Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_4DMineur>4)
	$max:=5
Else 
	$max:=4
End if 
$typeRef:=2
$LV_mode:=False:C215

C_COLLECTION:C1488($folders)  // shared collection
$folders:=MM_inFolderList

For ($ChoiceType; 0; $max)
	$data.clear()
	CLEAR VARIABLE:C89($tbPath)
	
	$type:=$typeRef^$ChoiceType  // 2^$choixtype
	METHOD GET PATHS:C1163($type; $tbPath; *)  // not PREEMPTIVE
	If ($type=1)
		METHODS_Remove_Compilers(->$tbPath)
	End if 
	
	$tbPathLength:=Size of array:C274($tbPath)
	If ($tbPathLength>0)
		
		Use ($declaration)
			$declaration.countMax:=$declaration.countMax+$tbPathLength
		End use 
		
		ARRAY OBJECT:C1221($tbAttributes; $tbPathLength)
		If (Not:C34($LV_mode))
			METHOD GET CODE:C1190($tbPath; $tabCodes; Code with tokens:K72:18; *)
			METHOD GET MODIFICATION DATE:C1170($tbPath; $tabDates; $tabHeures; *)
		End if 
		
		$o:=New object:C1471
		
		Case of 
				
			: ($type=Path project method:K72:1)  //1
				$Message:="Path project method"
				METHOD GET ATTRIBUTES:C1334($tbPath; $tbAttributes; *)
				
				// PE 26/11/20
				If ($1.last=Null:C1517)
					$lastPart:=""
				Else 
					$lastPart:=$1.last
				End if 
				
				If ((Position:C15("called"; $lastPart)>0) & (Position:C15("times, Thread"; $lastPart)>0))
					If (Is Windows:C1573)
						$coll:=Split string:C1554($lastPart; "\r\n")
					Else 
						$coll:=Split string:C1554($lastPart; "\r")
					End if 
					$coll.shift()
					
					//If ($coll.length>0) // To prevent a $coll
					For each ($line; $coll)
						
						If ($line#"")
							// use Comma as split separator
							$splitLine:=Split string:C1554($line; ",")
							$mName:=Substring:C12($splitLine[0]; Position:C15(" "; $splitLine[0])+1)
							If (Position:C15("("; $mName)>0)
								$methodName:=Substring:C12($mName; 1; Position:C15("("; $mName)-1)
							Else 
								$methodName:=$mName
							End if 
							$thread:=Substring:C12($splitLine[2]; Position:C15(" "; $splitLine[2])+1)
							$o[$methodName]:=New object:C1471("syntax"; $mName; "threadSafe"; Bool:C1537($thread="Thread Safe"))
						End if 
						
					End for each 
				End if 
				
				Use ($declaration)
					$declaration.syntax:=New shared object:C1526
					OB_CopyToSharedObject($o; $declaration.syntax)
				End use 
				
				
			: ($type=Path database method:K72:2)  // 2
				$Message:="Path database method"
				
			: ($type=Path project form:K72:3)  // 4
				$Message:="Path project form"
				
			: ($type=Path trigger:K72:4)  // 8
				$Message:="Path trigger"
				
			: ($type=Path table form:K72:5)  // 16
				$Message:="Path table form"
				
			: ($type=Path class:K72:19)  // Path class // 32
				$Message:="Path Class"
				
		End case 
		
		If ($LV_mode)
			ARRAY TO COLLECTION:C1563($data; $tbPath; "path"; $tbAttributes; "attributes")
		Else 
			ARRAY TO COLLECTION:C1563($data; $tbPath; "path"; $tabCodes; "code"; $tbAttributes; "attributes"; $tabDates; "lastDate"; $tabHeures; "lastTime")
		End if 
		
		$i:=0
		$newSignal:=New signal:C1641
		signal_setNew($newSignal; $data.length)
		
		For each ($method; $data)
			
			$i:=$i+1
			CALL WORKER:C1389("QST_mAnalysis_"+String:C10($type)+"_"+String:C10($i); "MM_setMethodAttributes"; $method; $Message; $declaration; $folders; $newSignal)
			If ($i=Storage:C1525.QS_TBX_SHARED_DATA.maxWorkers)
				$i:=0
			End if 
			
		End for each 
		
		$newSignal.wait()
		
	End if 
End for 

Use ($declaration)
	$declaration:=New shared object:C1526
End use 

// -------------- Record QS_TBX_allMethods in storage.allMethods --------------------
If (Count parameters:C259=2)
	var $2 : Object
	signal_addResult($2; Current method name:C684)
End if 

CALL WORKER:C1389("QST_setCollToDiamond"; "WKR_setCollToDiamond"; "method"; 1)
ON ERR CALL:C155($onErrCallMethod)

