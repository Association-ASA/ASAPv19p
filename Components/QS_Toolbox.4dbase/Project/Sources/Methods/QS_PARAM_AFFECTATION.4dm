//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 04/10/17, 07:59:07
// ----------------------------------------------------
// Méthode : QS_PARAM_AFFECTATION
// Description
// Dispatche les valeurs des tableaux dans les variables adéquates
//
// Paramètres
// ----------------------------------------------------

#DECLARE($blob : Blob)
var $data : Collection
$data:=New collection:C1472
BLOB TO VARIABLE:C533($blob; $data)

var $SharedData : Object
$SharedData:=Storage:C1525.QS_TBX_SHARED_DATA

Use ($SharedData)
	$SharedData.QS_SETUP_COMMENT_LOW:=Num:C11($data[0].value)
	$SharedData.QS_SETUP_COMMENT_MEDIUM:=Num:C11($data[1].value)
	$SharedData.QS_SETUP_COMMENT_HIGH:=Num:C11($data[2].value)
	$SharedData.QS_SETUP_COMPLEX_LOW:=Num:C11($data[3].value)
	$SharedData.QS_SETUP_COMPLEX_MEDIUM:=Num:C11($data[4].value)
	$SharedData.QS_SETUP_COMPLEX_HIGH:=Num:C11($data[5].value)
	$SharedData.QS_SETUP_MAX_COMMENT_LINES:=Num:C11($data[6].value)
	$SharedData.QS_TBX_MAX_LOOP:=Num:C11($data[7].value)
	$SharedData.QS_TBX_TypeLog:=Num:C11($data[8].value)
	$SharedData.QS_TBX_CHECH_NEW_METHOD:=Num:C11($data[9].value)
	$SharedData.QS_TBX_inLine:=Num:C11($data[10].value)
	$SharedData.QS_TBX_CHECH_lines:=Num:C11($data[11].value)
	$SharedData.maxWorkers:=Num:C11($data[13].value)
	$SharedData.startDBAnalysis:=Num:C11($data[14].value)
End use 

$path:=Get 4D folder:C485(Current resources folder:K5:16)+"4dpop.xml"
$xmlTxt:=Document to text:C1236($path)

If (Num:C11($data[12].value)=0)  // Don't start automatically
	If (Position:C15("initproc="; $xmlTxt)>0)  // The option is already set
		$xmlTxt:=Replace string:C233($xmlTxt; " initproc=\"QS_init\""; "")
		TEXT TO DOCUMENT:C1237($path; $xmlTxt)
	End if 
	
Else   // Start automatically
	If (Position:C15("initproc="; $xmlTxt)=0)  // The option is already set
		$xmlTxt:=Replace string:C233($xmlTxt; "4DPop.png\""; "4DPop.png\" initproc=\"QS_init\"")
		TEXT TO DOCUMENT:C1237($path; $xmlTxt)
	End if 
End if 