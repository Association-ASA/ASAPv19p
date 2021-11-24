//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 10/02/18, 15:14:08
  // ----------------------------------------------------
  // Méthode : STRCT_UpdateDisplay
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------

ARRAY OBJECT:C1221($arrTable;0x0000)
C_POINTER:C301($zptTable)
$zptTable:=Table:C252(Form:C1466.numTable)
Form:C1466.oStructure:=STRCT_GetDatabaseStructure 
OB GET ARRAY:C1229(Form:C1466.oStructure;"table";$arrTable)
For ($i;1;Size of array:C274($arrTable))
	If ($arrTable{$i}.name=Table name:C256($ZptTable))
		$oTable:=$arrTable{$i}
		$i:=Size of array:C274($arrTable)+1
	End if 
End for 
STRCT_displayField ($oTable)