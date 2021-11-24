//%attributes = {"invisible":true,"preemptive":"capable","publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Méthode : ORDA_windowNumberToStorage
  // ----------------------------------------------------
  // Paramètres
  // $1 = Attribut to create into Storage (Text)
  // $2 = Value to save (LongInt)
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 12/07/18, 11:22:48
  // Description
  // example: Save window number information into Storage.window[$1]

C_TEXT:C284($1)
C_LONGINT:C283($2)

C_OBJECT:C1216($Parameter)

$Parameter:=Storage:C1525.windows
Use (Storage:C1525)
	Use ($Parameter)
		$Parameter[$1]:=$2
	End use 
End use 