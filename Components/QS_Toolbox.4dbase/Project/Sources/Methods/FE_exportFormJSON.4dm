//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// nom utilisateur (OS) : Association QualiSoft
// date et heure : 30/04/16, 16:06:55
// ----------------------------------------------------
// méthode : FE_ExportFormulaireJSON
// description
//
//
// paramètres
// ----------------------------------------------------

C_OBJECT:C1216($FormDetail)
C_TEXT:C284($Texte)

$formulareName:=Form:C1466.formulare
$tableNumber:=Form:C1466.tableNum

If ($formulareName#"")
	
	$FormDetail:=New object:C1471
	$FormDetail.tableNum:=Form:C1466.tableNum
	$FormDetail.formName:=Form:C1466.formulare
	$txt:=""
	If ($tableNumber>0)
		$FormDetail.tableName:=Storage:C1525.structureTable.query("id =:1"; Form:C1466.tableNum)[0].name
		$txt:="["+$FormDetail.tableName+"]"
	Else 
		$FormDetail.tableName:="{Project Form}"
	End if 
	
	SUPPORT_form_GetJSON($FormDetail)
	$Texte:=JSON Stringify:C1217($FormDetail; *)
	
	$nom:=Choose:C955($tableNumber>0; OB Get:C1224($FormDetail; "tableName")+" - "+$formulareName; $formulareName)
	$chemin:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DestinationPath+"Export JSON"+Folder separator:K24:12
	$chemin:=$chemin+$nom+".txt"
	
	If (Test path name:C476($chemin)=Is a document:K24:1)
		DELETE DOCUMENT:C159($chemin)
	End if 
	
	TEXT TO DOCUMENT:C1237($chemin; $Texte)
	SHOW ON DISK:C922($chemin)
End if 
