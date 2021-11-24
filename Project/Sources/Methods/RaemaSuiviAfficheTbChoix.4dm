//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 15/08/18, 07:18:06
// ----------------------------------------------------
// Paramètres
// ----------------------------------------------------
// Méthode : RaemaSuiviAfficheTbChoix
// Description
// Affiche dans le tableau de "DlgSuiviResultats"
//  la liste des laboratoires choisis dans PUMChoix
// ----------------------------------------------------

// SÉLECTION VERS TABLEAU([CampagneParticipation]NumLaboEntier;TbParticipantN;[CampagneParticipation]TexteParticipation1;TbHistorique)
//TRIER([CampagneParticipation];[CampagneParticipation]UUIDPersonne;>)
$FT:=Records in selection:C76([CampagneParticipations:17])
ARRAY LONGINT:C221(TbParticipantN; $FT)
ARRAY LONGINT:C221(TbCouleurFond; $FT)
ARRAY TEXT:C222(TbParticipantA; $FT)
ARRAY TEXT:C222(TbTexteParticipation; $FT)
$Couleur:=0x00FFFFFF
VarCouleurAbsent:=0x00F9B09A
VarCouleurEnCours:=0x00F2F290
VarCouleurRecu:=0x00C0F99A
SELECTION TO ARRAY:C260([CampagneParticipations:17]UUIDPersonne:2; $TbUUIDPersonne\
; [CampagneParticipations:17]Arguments:5; $TbArgument\
; [CampagneParticipations:17]UUID:1; $TbUUIDParticipation\
; [CampagneParticipations:17]TexteParticipation:4; $TbTexteParticipe)

// DÉBUT SELECTION([CampagneParticipations])
For ($Salé; 1; $FT)
	TbParticipantA{$Salé}:=String:C10(ASAPTrouveNumeroLaboParUUID($TbUUIDPersonne{$Salé}))
	TbParticipantN{$Salé}:=Num:C11(TbParticipantA{$Salé})
	$RL:=OB Get:C1224($TbArgument{$Salé}; "CodeRaemaLié"; Est un texte:K8:3)
	$RL:=$TbArgument{$Salé}.CodeRaemaLié  // première utilisation de la notation pointée par cgm !!!!
	If ($RL#"")
		$RL:=Substring:C12($RL; 1; 10)
		TbParticipantA{$Salé}:=TbParticipantA{$Salé}+" - "+String:C10(RAEMADemoduleMdPWeb($RL))
	End if 
	TbTexteParticipation{$Salé}:=$TbTexteParticipe{$Salé}
	Case of 
		: (Find in array:C230(TbEnvoyé; $TbUUIDParticipation{$Salé})>0)
			$Couleur:=0x00C0F99A
			
		: (Find in array:C230(TbAbsent; $TbUUIDParticipation{$Salé})>0)
			$Couleur:=0x00F9B09A
			
		Else   // en cours
			$Couleur:=0x00F2F290
	End case 
	TbCouleurFond{$Salé}:=$Couleur
	// ENREGISTREMENT SUIVANT([CampagneParticipations])
End for 
LONGINT ARRAY FROM SELECTION:C647([CampagneParticipations:17]; TbNumEnrLP)

MULTI SORT ARRAY:C718(TbParticipantN; >; TbParticipantA; >; TbTexteParticipation; TbCouleurFond; TbNumEnrLP)
VarNbLaboP:=Size of array:C274(TbParticipantA)

