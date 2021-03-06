//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 12/08/18, 11:36:53
// ----------------------------------------------------
// Paramètre : aucun
// ----------------------------------------------------
// Méthode : RaemaLotoFabriquePage
// Description
// Ecrit les 100  variables VarNLFPi des laboratoires participants 
// et les 100 variables VarNLFNPi des laboratoires non participants
// en fonction de la page courante (NbrePage)
// ----------------------------------------------------
C_LONGINT:C283($Salé; $Fumé; $FT; $TT; $L)
// Initialisons les variables qui comptent les # types de ârticipations
Nb1A:=""
Nb2A:=""
Nb3A:=""
Nb4A:=""

NumCampagne:=PUMNRFLP{PUMNRFLP}
QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]NumCampagne:3=NumCampagne; *)
QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17];  & ; [CampagneParticipations:17]Arguments:5; "Sauvage"; =; Null:C1517)
SELECTION TO ARRAY:C260([CampagneParticipations:17]UUIDPersonne:2; $TbUUIDLabo; [CampagneParticipations:17]Arguments:5; $TbArgument)
ARRAY LONGINT:C221(TbLotoListeParticipants; 0)
ARRAY TEXT:C222(TbLotoListeParticipantsA; 0)
// OB LIRE TABLEAU([RAEMACampagnes]Arguments;"Loto";TbLotoListeParticipants)

RaemaLotoInitTableauCouleur

$TT:=Size of array:C274($TbUUIDLabo)
VarNbLabos:=$TT
ARRAY LONGINT:C221(TbLotoCouleurLabo; $TT)  // Le tableau qui recueille la couleur affichée
$Rouge:=0x00E6B8A8
$Bleu:=0x00C9D8F9
$Noir:=0x00FFFFFF
$Gris:=0x00DFDFDF

// Constitution des tableaux de la ListBox ListBoxLoto
$NbRouge:=0
$NbBleu:=0
$NbGris:=0
$NbBlanc:=0

For ($Fumé; 1; $TT)
	$NumLaboA:=ASAPTrouveNumeroLaboParUUID($TbUUIDLabo{$Fumé})
	$NumLaboN:=Num:C11($NumLaboA)
	
	APPEND TO ARRAY:C911(TbLotoListeParticipants; $NumLaboN)
	$RaemaLié:=""
	$RaemaLié:=OB Get:C1224($TbArgument{$Fumé}; "CodeRaemaLié"; Est un texte:K8:3)
	If ($RaemaLié#"")
		$NumRLA:=String:C10(RAEMADemoduleMdPWeb($RaemaLié))
		APPEND TO ARRAY:C911(TbLotoListeParticipantsA; $NumRLA)
	Else 
		APPEND TO ARRAY:C911(TbLotoListeParticipantsA; $NumLaboA)
	End if 
	$IdentifiantLaboParticipation:=$NumLaboA+"_"+NumCampagne+"_"
	$L:=Find in array:C230(<>TbLotoIdentifiantParticipation; $IdentifiantLaboParticipation)
	If ($L>0)
		If (NumCampagne="@A")  // RAEMA gel
			$NbColisSans:=0
			$NbColisAvec:=0
			$FT:=Size of array:C274(<>TbNomGermeSchémaGEL)
			For ($Salé; 1; $FT)
				$NbColisSans:=$NbColisSans+<>TbPtTbLotoGermeGELNCGSR{$Salé}->{$L}
				$NbColisAvec:=$NbColisAvec+<>TbPtTbLotoGermeGELNCGAR{$Salé}->{$L}
			End for 
			Case of 
				: ($NbColisAvec#0)
					TbLotoCouleurLabo{$Fumé}:=$Rouge  // Rouge = pots supplémentaires avec rapport
					$NbRouge:=$NbRouge+1
					
				: ($NbColisSans#0)
					TbLotoCouleurLabo{$Fumé}:=$Bleu  // Bleu = pots supplémentaires sans rapport 
					$NbBleu:=$NbBleu+1
					
				Else 
					TbLotoCouleurLabo{$Fumé}:=$Noir  // Noir = sans pot supplémentaire 
					$NbBlanc:=$NbBlanc+1
					
			End case 
		Else   // RAEMA poudre
			Case of 
				: (<>TbLotoNbColisPoudreAR{$L}#0)
					TbLotoCouleurLabo{$Fumé}:=$Rouge  // Rouge = pots supplémentaires avec rapport
					$NbRouge:=$NbRouge+1
					
				: (<>TbLotoNbColisPoudreSR{$L}#0)
					TbLotoCouleurLabo{$Fumé}:=$Bleu  // Bleu = pots supplémentaires sans rapport 
					$NbBleu:=$NbBleu+1
					
				Else 
					TbLotoCouleurLabo{$Fumé}:=$Noir  // Noir = sans pot supplémentaire 
					$NbBlanc:=$NbBlanc+1
			End case 
		End if 
		
	Else   // Le laboratoire était inscrit mais n'a pas rendu de résultats
		TbLotoCouleurLabo{$Fumé}:=$Gris  // Gris = inscrit sans participer
		$NbGris:=$NbGris+1
		
	End if 
End for 
MULTI SORT ARRAY:C718(TbLotoListeParticipants; >; TbLotoListeParticipantsA; >; TbLotoCouleurLabo)

$FT:=($TT\30)+1
For ($Salé; 1; $FT)
	For ($Sec; 1; 30)  // Pour les 30 colonnes de la ListBox ListBoxLoto
		$Rang:=(30*($Salé-1))+$Sec
		$PtV:=Get pointer:C304("Colonne"+String:C10($Sec))
		$PtC:=Get pointer:C304("TbCouleurFond"+String:C10($Sec))
		If ($Rang>$TT)
			APPEND TO ARRAY:C911($PtV->; "")
			APPEND TO ARRAY:C911($PtC->; $Noir)
		Else 
			APPEND TO ARRAY:C911($PtV->; TbLotoListeParticipantsA{$Rang})
			APPEND TO ARRAY:C911($PtC->; TbLotoCouleurLabo{$Rang})
		End if 
	End for 
	If ($Rang>$TT)
		$Salé:=$FT
	End if 
End for 
Nb1A:=String:C10($NbBleu)
Nb2A:=String:C10($NbRouge)
Nb3A:=String:C10($NbGris)