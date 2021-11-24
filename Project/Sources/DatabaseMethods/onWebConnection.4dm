C_TEXT:C284($1; $2; $3; $4; $5; $6; NavigateurLabo)
// APPELER SUR ERREUR("aaaErreur")

//TRACE
NavigateurLabo:=$2
// RaemaQuelNavigateur ($2)
ZAmnistieInternationale
IP:=$3
$Mess:=$1

If (Macintosh command down:C546) & (Macintosh option down:C545)
	TRACE:C157
End if 

If ($Mess="/@")
	$Mess:=Substring:C12($Mess; 2)
End if 

If ($Mess="asadia") | ($Mess="asadia/")
	DiaWebEcritPageDepartFr
Else 
	Case of 
		: ($Mess="w2@")  // navigation d'une page à l'autre
			$NomFichier:=Substring:C12($Mess; 3)
			WEB SEND FILE:C619($NomFichier)
			
		: ($Mess="mw2@")  // gestion des envois de formulaire
			$NomMéthode:=Substring:C12($Mess; 4)
			ARRAY TEXT:C222($TbNomsMéthodes; 0)
			METHOD GET PATHS:C1163(Chemin tous les objets:K72:16; $TbNomsMéthodes)
			If (Find in array:C230($TbNomsMéthodes; $NomMéthode)>0)
				EXECUTE METHOD:C1007($NomMéthode)
			End if 
			
		Else   // Gestions AJAX
			ASAPSurConnexionWeb($Mess)
			DiaSurConnexionWeb($Mess)
			// APPELER SUR ERREUR("")
	End case 
	// Page "Oups"
End if 

ZAmnistieInternationale