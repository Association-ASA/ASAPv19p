//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // nom utilisateur (OS) : Association QualiSoft
  // date et heure : 01/08/14, 18:53:02
  // ----------------------------------------------------
  // méthode : PM_methodsCodeToPaperboard
  // description
  //
  //
  // paramètres
  // ----------------------------------------------------

  // http://forums.4d.fr/Post/FR/15024537/1/15024822#15024822

C_OBJECT:C1216($ent)
C_TEXT:C284($out_t)

If (Form:C1466.methodSelected.length=0)
	Form:C1466.methodSelected:=Form:C1466.listboxDisplayed
End if 

$out_t:="Code of "+String:C10(Form:C1466.methodSelected.length)+" methods from "+Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DBName+": "+String:C10(Date:C102(Current date:C33))+" @ "+String:C10(Current time:C178)+"\r"

For each ($ent;Form:C1466.methodSelected)
	$out_t:=$out_t+"\r\r*** "+$ent.name+" ***\r"
	$out_t:=$out_t+Substring:C12($ent.code;Position:C15("\r";$ent.code;1)+1)
End for each 
SET TEXT TO PASTEBOARD:C523($out_t)

$out_t:=String:C10(Form:C1466.methodSelected.length)+" project methods copied and ready to be pasted."
displayInfo ($out_t)
