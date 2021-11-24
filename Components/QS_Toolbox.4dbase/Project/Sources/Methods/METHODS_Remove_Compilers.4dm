//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 29/03/18, 20:19:57
  // ----------------------------------------------------
  // Méthode : METHODS_Remove_Compilers
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------

C_POINTER:C301($1)

For ($i;Size of array:C274($1->);1;-1)
	If ($1->{$i}="Compiler_@")
		DELETE FROM ARRAY:C228($1->;$i;1)
	End if 
End for 
