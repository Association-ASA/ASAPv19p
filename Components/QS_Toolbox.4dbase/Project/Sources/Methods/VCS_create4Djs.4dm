//%attributes = {"invisible":true,"preemptive":"capable","publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// ----------------------------------------------------
// No parameter
// ----------------------------------------------------
// Méthode : VCS_create4Djs
// Description
// 
// ----------------------------------------------------
// Nom utilisateur (OS) : Patrick EMANUEL
// Date et heure : 15/05/20, 10:36:03
// Paramètres

C_TEXT:C284($QS_txt_AllMethods; $QS_txt_4D_commands; $QS_txt_konstants; $QS_txt_componants; $QS_txt_systemKeywords)
C_TEXT:C284($w_HTMLfile)
C_COLLECTION:C1488($temp)

CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; Current method name:C684+" -> Start")

$QS_txt_AllMethods:="Path project method"
$temp:=Storage:C1525.allMethods.query("path = :1 and orderBy name"; $QS_txt_AllMethods).extract("name")
If ($temp.length=0)  // bug from Lutz Veith
	$temp.push("xxxxxxzzzzz")
End if 
$QS_txt_AllMethods:=JSON Stringify:C1217($temp)
$QS_txt_AllMethods:=Replace string:C233($QS_txt_AllMethods; "\""; "'")

//$temp:=storage.plugIn.extract("name").orderBy(ck descending)
//$QS_txt_4D_plugIns:=JSON Stringify($temp)
//$QS_txt_4D_plugIns:=Replace string($QS_txt_4D_plugIns;"\"";"'")

//$temp:=Storage.keywords.extract("EN").orderBy(ck descending)
//$QS_txt_keyword:=JSON Stringify($temp)
//$QS_txt_keyword:=Replace string($QS_txt_keyword;"\"";"'")

$temp:=Storage:C1525.constants.distinct("EN").orderBy(ck descending:K85:8)
If ($temp[$temp.length-1]="")
	$temp.remove($temp.length-1)
End if 
$QS_txt_konstants:=JSON Stringify:C1217($temp)
$QS_txt_konstants:=Replace string:C233($QS_txt_konstants; "\""; "'")

$QS_txt_componants:="['"+Storage:C1525.keywords.extract("method").orderBy(ck descending:K85:8).join("','")+"']"
$QS_txt_systemKeywords:="['"+Storage:C1525.systemKeywords.extract("name").orderBy(ck descending:K85:8).join("','")+"']"
$QS_txt_4D_commands:="['"+Storage:C1525.commands4d.extract("EN").orderBy(ck descending:K85:8).join("','")+"']"

$txtTemplate_t:=File:C1566("/RESOURCES/codemirror/mode/4d/4d_template.js").getText("UTF-8")
$docPath_t:=File:C1566("/RESOURCES/codemirror/mode/4d/4d.js")

PROCESS 4D TAGS:C816($txtTemplate_t; $w_HTMLfile; $QS_txt_4D_commands; $QS_txt_konstants; $QS_txt_AllMethods; $QS_txt_systemKeywords)

If ($docPath_t.exists)
	$docPath_t.delete()
End if 
$docPath_t.create()
$docPath_t.setText($w_HTMLfile)

If (Count parameters:C259=1)
	C_OBJECT:C1216($1)
	signal_addResult($1; Current method name:C684)
End if 

CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; Current method name:C684+" -> End")