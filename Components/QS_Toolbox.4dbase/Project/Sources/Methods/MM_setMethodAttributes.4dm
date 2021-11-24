//%attributes = {"invisible":true}
C_OBJECT:C1216($1;$method;$3;$declaration;$LV_method)
C_COLLECTION:C1488($4;$folders;$coll)
C_TEXT:C284($Message;$2;$code)

$method:=$1
$Message:=$2
$declaration:=$3
$folders:=$4
$result:=New collection:C1472
$Coll:=New collection:C1472
$founded:=New collection:C1472
$toUpdate:=False:C215

C_BOOLEAN:C305($LV_mode)
$LV_mode:=False:C215

If ($LV_mode)
	$LV_method:=Storage:C1525.LV_parseCode[$method.path]
	
	$newMethod:=New object:C1471(\
		"name";$LV_method.path;\
		"code";$LV_method.code;\
		"clearCode";"";\
		"folder";"-";\
		"attributes";$method.attributes;\
		"lastUpdate";Date:C102($LV_method.mod);\
		"timeUpdate";Time:C179($LV_method.mod);\
		"epoch";UTIL_epoch (Date:C102($LV_method.mod);Time:C179($LV_method.mod));\
		"nbLines";0;\
		"nbEmpty";0;\
		"nbComment";0;\
		"nbNested";0;\
		"Complexity";0;\
		"path";$Message;\
		"syntax";"";\
		"pluginUsed";New collection:C1472;\
		"pluginToken";New collection:C1472;\
		"constantUsed";$LV_method.usedCst;\
		"constantToken";New collection:C1472;\
		"commandUsed";$LV_method.usedCmd;\
		"commandToken";New collection:C1472;\
		"callees";New collection:C1472;\
		"callers";New collection:C1472;\
		"isThread";False:C215;\
		"checkOnStart";False:C215;\
		"localVariables";$LV_method.usedVlc;\
		"ipVariables";$LV_method.usedVip;\
		"BlockBegin";$LV_method.usedBb;\
		"BlockMiddle";$LV_method.usedBm;\
		"BlockEnd";$LV_method.usedBe;\
		"hasDescription";False:C215\
		)
	
	  // "callees";$LV_method.callees;"callers";$LV_method.callers;
	
Else 
	
	$newMethod:=New object:C1471(\
		"name";$method.path;\
		"code";$method.code;\
		"clearCode";"";\
		"folder";"-";\
		"attributes";$method.attributes;\
		"lastUpdate";$method.lastDate;\
		"timeUpdate";$method.lastTime;\
		"epoch";UTIL_epoch (Date:C102($method.lastDate);Time:C179($method.lastTime));\
		"nbLines";0;\
		"nbEmpty";0;\
		"nbComment";0;\
		"nbNested";0;\
		"Complexity";0;\
		"path";$Message;\
		"syntax";"";\
		"pluginUsed";New collection:C1472;\
		"pluginToken";New collection:C1472;\
		"constantUsed";New collection:C1472;\
		"constantToken";New collection:C1472;\
		"commandUsed";New collection:C1472;\
		"commandToken";New collection:C1472;\
		"callees";New collection:C1472;\
		"callers";New collection:C1472;\
		"isThread";False:C215;\
		"checkOnStart";False:C215;\
		"hasDescription";False:C215\
		)
	
End if 

  //If (Storage.allMethods.length>0)
  //$founded:=Storage.allMethods.query("name =:1";$method.path)
  //End if 

  //Case of 
  //: ($founded.length=0)  // $method.path not exists in QST
  //$toUpdate:=True

  //: ($founded.length=1) & ($timeStamp#$founded[0].timestamp)  // timestamp is NOT the same => need to update
  //$toUpdate:=True

  //Else 
  //$newMethod:=$founded

  //End case 

  //  // Need to update a Method => do like is a New one
  //If ($toUpdate)

  //$code:=Uppercase($LV_method.code)

METHODS_clearCode ($newMethod)
METHODS_hasDescription ($newMethod)

  // -- Folder --
$coll:=$folders.query("name = :1";$newMethod.name)
If ($coll.length>0)
	$newMethod.folder:=$coll[0].folder
End if 
  // --


If ($Message="Path project method")
	METHODS_getSyntax ($newMethod;$declaration)
End if 

If ($Message#"Path Class")
	METHODS_analyseOne ($newMethod)  // Determination of the complexity...
	METHODS_get4dInformation ($newMethod)
	
	For each ($toAnalyse;$newMethod.constantUsed)
		$txt:=Parse formula:C1576($toAnalyse;Formula out with tokens:K88:3)
		$newMethod.constantToken.push(Substring:C12($txt;Position:C15(":";$txt)))
	End for each 
	
	For each ($toAnalyse;$newMethod.commandUsed)
		$txt:=Parse formula:C1576($toAnalyse;Formula out with tokens:K88:3)
		$newMethod.commandToken.push(Substring:C12($txt;Position:C15(":";$txt)))
	End for each 
	
End if 

  //End if 

$result.push($newMethod)
C_OBJECT:C1216($signal)
$signal:=New signal:C1641
CALL WORKER:C1389("QST_setCollToDiamond";"WKR_setCollToDiamond";$result;1;$signal)
$signal.wait()

CALL WORKER:C1389("QST_debug";"floatWindow_send";Current process name:C1392;$method.path)
Use ($declaration)
	$declaration.count:=$declaration.count+1
End use 

If (Count parameters:C259=5)
	C_OBJECT:C1216($5)
	signal_addResult ($5;Current method name:C684)
End if 
