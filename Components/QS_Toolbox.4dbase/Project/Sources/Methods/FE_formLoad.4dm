//%attributes = {"invisible":true,"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 01/06/19, 10:39:04
  // Paramètres
  // ----------------------------------------------------
  // $1 : table number
  // $2 : formulare name
  // ----------------------------------------------------
  // Méthode : FormLoad
  // Description
  // 
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_POINTER:C301($ZptTable)

If ($1>0)
	$ZptTable:=Table:C252($1)
	  // Securise the access
	If (Is nil pointer:C315($ZptTable)=False:C215) & ($2#"")
		FORM LOAD:C1103($ZptTable->;$2;*)  // Table Forms from the host DB
	End if 
	
Else 
	FORM LOAD:C1103($2;*)  // Project Forms from the host DB
End if 