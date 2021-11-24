//%attributes = {"invisible":true,"executedOnServer":false,"preemptive":"capable","publishedSql":false,"publishedWsdl":false,"shared":false,"publishedWeb":false,"publishedSoap":false,"published4DMobile":{"scope":"none"}}
C_OBJECT:C1216($2;$o)
C_LONGINT:C283($pos;$len)
C_TEXT:C284($Language;$3;$allCode)
C_COLLECTION:C1488($1;$used_commands;$coll)
ARRAY LONGINT:C221($tb_Pos;0)
ARRAY LONGINT:C221($tb_Len;0)

$used_commands:=$1
$o:=$2
$allCode:=$3
$Language:=Config_getLanguage 
$coll:=New collection:C1472

CALL WORKER:C1389("QST_debug";"floatWindow_send";Current process name:C1392;"Count: "+$o[$Language])

$count:=0
$position:=1
$command_name:=$o[$Language]
$token:=$o.token

$coll:=Split string:C1554($allCode;$command_name+$token)
If (Position:C15($command_name+$token;$coll[$coll.length-1])=0)  // Just to confirm that the last line contains the Pattern searched
	$coll.remove($coll.length-1)
End if 

If ($coll.length>0)  // Just  in case of False result
	Use ($used_commands)
		$used_commands.push(New shared object:C1526("command";$command_name;"count";$coll.length))
	End use 
End if 

If (Count parameters:C259=4)
	C_OBJECT:C1216($4)
	signal_addResult ($4;Current method name:C684)
End if 