//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 22/04/19, 10:42:53
// ----------------------------------------------------
// Méthode : ASAPMAJCheminDocument
// Description
//   Méthode qui ajoute dans [CampagneParticipations]Arguments
//   le chemin du rapport s'il existe
//   cette méthode sera exécutée sur le serveur 
//   où se trouvent les documents
// ----------------------------------------------------

C_LONGINT:C283($Salé; $L; $FT)
$FT:=Size of array:C274(<>TbLotoIdentifiantParticipation)  // Type "14_66_FtRQTZqPPT"
$CD:=<>PermCheDosRap


READ WRITE:C146([CampagneParticipations:17])
For ($Salé; 1; $FT)
	$Participation:=<>TbLotoIdentifiantParticipation{$Salé}
	$Pos:=Position:C15("_"; $Participation)
	$NumLaboA:=Substring:C12($Participation; 1; ($Pos-1))
	$Participation:=Substring:C12($Participation; ($Pos+1))
	$Pos:=Position:C15("_"; $Participation)
	$NumCampagne:=Substring:C12($Participation; 1; ($Pos-1))
	$CodeRaemalié:=Substring:C12($Participation; ($Pos+1))
	If ($CodeRaemalié#"")
		$NumLaboA:=String:C10(RAEMADemoduleMdPWeb($CodeRaemalié))
	End if 
	$NomFichierRapport:=$CD+$NumLaboA+Séparateur dossier:K24:12+"RI"+$NumCampagne+"_"+$NumLaboA+".pdf"
	QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]UUID:1=<>TbLotoUUIDParticipation{$Salé})
	If (Test path name:C476($NomFichierRapport)=Est un document:K24:1)
		OB SET:C1220([CampagneParticipations:17]Arguments:5; "CheminDocument"; $NomFichierRapport)
	Else 
		OB REMOVE:C1226([CampagneParticipations:17]Arguments:5; "CheminDocument")
	End if 
	SAVE RECORD:C53([CampagneParticipations:17])
End for 
ZAmnistiePartielle(->[CampagneParticipations:17])