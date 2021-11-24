//%attributes = {"invisible":true,"executedOnServer":false,"preemptive":"capable","publishedSql":false,"publishedWsdl":false,"shared":false,"publishedWeb":false,"publishedSoap":false,"published4DMobile":{"scope":"none"}}
  // stats_parseCommand
  // Paramètres
  // ----------------------------------------------------
  //
  //
  // Description
  // 
  // ----------------------------------------------------
  // Creation: Patrick EMANUEL, 25/08/20, 11:29:26
  //

C_COLLECTION:C1488($allMethods;$allCommands;$coll)
C_COLLECTION:C1488($used_commands)
C_TEXT:C284($Language;$token;$allCode)
C_OBJECT:C1216($signal)
C_REAL:C285($pas)
C_LONGINT:C283($window)
C_LONGINT:C283($pos;$len)
C_OBJECT:C1216($param;$o)

CALL WORKER:C1389("QST_debug";"floatWindow_send";Current process name:C1392;Current method name:C684+" -> Start")

$allCommands:=Storage:C1525.commands4d
$used_commands:=New shared collection:C1527

$i:=0
  //$allCode:=Storage.allMethods.extract("code").join("\r")

C_COLLECTION:C1488($allTokens;$tokens;$temp)
C_TEXT:C284($token)
$allTokens:=Storage:C1525.allMethods.extract("commandToken")
$tokens:=New collection:C1472
For each ($temp;$allTokens)
	$tokens:=$tokens.combine($temp)
End for each 
$tokens:=$tokens.distinct()

$signal:=New signal:C1641
signal_setNew ($signal;$tokens.length)

For each ($token;$tokens)
	$coll:=Storage:C1525.commands4d.query("token =:1";$token)
	If ($coll.length>0)
		$o:=$coll[0]
		$allCode:=Storage:C1525.allMethods.query("commandToken[] =:1";$o.token).extract("code").join("\r")
		$i:=$i+1
		CALL WORKER:C1389("QST_countCommand_"+String:C10($i);"stat_wkr_count";$used_commands;$o;$allCode;$signal)
		If ($i=(Storage:C1525.QS_TBX_SHARED_DATA.maxWorkers+2))
			$i:=0
		End if 
	Else 
		signal_addResult ($signal;Current method name:C684)
	End if 
	
End for each 
$signal.wait()

$0:=$used_commands.orderBy("count desc, command asc")
CALL WORKER:C1389("QST_debug";"floatWindow_send";Current process name:C1392;Current method name:C684+" -> End")