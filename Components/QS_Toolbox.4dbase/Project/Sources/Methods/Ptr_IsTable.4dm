//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 10/06/18, 07:45:00
  // ----------------------------------------------------
  // Paramètres
  // $1 = 
  // $2 = 
  // ----------------------------------------------------
  // Méthode : Ptr_IsTable
  // Description
  //  http://forums.4d.com/Post/FR/4942528/1/4942529#4942529

  //Ptr_isTable (varPtr) -> bool
C_BOOLEAN:C305($0)
C_POINTER:C301($1)
C_TEXT:C284($sNomVar)
C_LONGINT:C283($lNoTable;$lNoChamp)
  //_
$0:=False:C215
If (Count parameters:C259<1)
	  //manage error
Else 
	RESOLVE POINTER:C394($1;$sNomVar;$lNoTable;$lNoChamp)
	$0:=($sNomVar="") & ($lNoTable>0) & ($lNoChamp=0)
End if 