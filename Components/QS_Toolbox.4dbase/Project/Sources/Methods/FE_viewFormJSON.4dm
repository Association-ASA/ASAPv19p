//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// nom utilisateur (OS) : Association QualiSoft
// date et heure : 30/04/16, 16:06:55
// ----------------------------------------------------
// méthode : SUPPORT_ViewFormulaireJSON
// description
//
//
// paramètres
// ----------------------------------------------------

var $FormDetail : Object
var $jsonText : Text

$FormDetail:=New object:C1471
$FormDetail.tableNum:=Form:C1466.tableNum
$FormDetail.formName:=Form:C1466.formulare
If ($FormDetail.tableNum>0)
	$FormDetail.tableName:=Storage:C1525.structureTable.query("id =:1"; Form:C1466.tableNum)[0].name
Else 
	$FormDetail.tableName:="{Project Form}"
End if 

SUPPORT_form_GetJSON($FormDetail)
$jsonText:=JSON Stringify:C1217($FormDetail; *)
SUPPORT_DisplayJSON(->$jsonText)