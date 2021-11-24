//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 03/05/20, 11:33:11
  // ----------------------------------------------------
  // Méthode : DiaAC2AfficheCandidates
  // Description
  // Méthode qui affiche les candidates  
  //  qui ont leur photo dans <>CDPhotosATraiter
  // Paramètre : aucun
  // ----------------------------------------------------

ARRAY OBJECT:C1221($TbObjetDia;0)
ARRAY TEXT:C222($TbCDDia;0)
ARRAY TEXT:C222($TbNomDia;0)
ARRAY REAL:C219($TbCasN;0)
$Type:="AjoutDia"+(Num:C11(PUMTypePhoto=2)*"G")
QUERY:C277([DiaData:45];[DiaData:45]XType:5=$Type)
  //CHERCHER([DiaData]; & [DiaData]XAlpha="A traiter")
SELECTION TO ARRAY:C260([DiaData:45]XObjet:15;$TbObjetDia\
;[DiaData:45]XNom:1;$TbNomDia\
;[DiaData:45]XValeur:4;$TbCasN\
;[DiaData:45]XType:5;$TbTypeDia\
;[DiaData:45]XTexte:7;$TbCDDia)
LONGINT ARRAY FROM SELECTION:C647([DiaData:45];$TbNumEnrDia)
  // Logos inscrustés
DOCUMENT LIST:C474(<>CDTags;$TbNomTag)
  // Couleurs
Antichambre2Verte:=0x00D9FFE7
Antichambre2Orange:=0x00FFF8D9
Antichambre2Rouge:=0x00FFE3E8
Antichambre2Blanc:=0x00FFFFFF
  // Photos à traiter
DOCUMENT LIST:C474(<>CDPhotosATraiter;$TbNomFichierATraiter;Ignorer invisibles:K24:16)
$FT:=Size of array:C274($TbNomFichierATraiter)
ARRAY TEXT:C222(TbAuteurDiapo;0)  // Auteur
ARRAY TEXT:C222(TbFichierDiapo;0)  // Nom du fichier
ARRAY TEXT:C222(TbTriplette;0)  // Triplette : lésion sur organe de espèce
ARRAY BOOLEAN:C223(TbTag;0)  // existance du logo incrusté 
ARRAY LONGINT:C221(TbNumEnrDia;0)  // le lien avec la [XDonnees]
ARRAY LONGINT:C221(TbCouleurFondA2;0)  // La couleur de fond
For ($Salé;1;$FT)
	$NomFichierCourant:=$TbNomFichierATraiter{$Salé}
	$NomInitialFichierCourant:=$NomFichierCourant
	If ($NomFichierCourant="T_@")
		$NomFichierCourant:=Substring:C12($NomFichierCourant;3)
	End if 
	$L:=Find in array:C230($TbNomDia;$NomFichierCourant)
	If ($L>0)
		If ($TbTypeDia{$L}=$Type)
			$Auteur:=$TbObjetDia{$L}.Auteur
			$TagB:=(Find in array:C230($TbNomTag;("TagPhoto"+$Auteur+".@"))>0)
			$Triplette:=$TbObjetDia{$L}.Lésion+" sur "+$TbObjetDia{$L}.Organe+" de "+$TbObjetDia{$L}.Espèce
			$NomFichier:=$TbNomDia{$L}
			$NumEnrDia:=$TbNumEnrDia{$L}
			$Couleur:=(Num:C11($TagB)*Antichambre2Verte)+(Num:C11(Not:C34($TagB))*Antichambre2Orange)
			APPEND TO ARRAY:C911(TbTag;$TagB)
			APPEND TO ARRAY:C911(TbAuteurDiapo;$Auteur)
			APPEND TO ARRAY:C911(TbFichierDiapo;$NomFichier)
			APPEND TO ARRAY:C911(TbTriplette;$Triplette)
			APPEND TO ARRAY:C911(TbNumEnrDia;$NumEnrDia)
			APPEND TO ARRAY:C911(TbCouleurFondA2;$Couleur)
		End if 
	Else 
		$TagB:=False:C215
		$Auteur:=""
		$Triplette:=""
		$NomFichier:=$NomInitialFichierCourant
		$NumEnrDia:=-1
		$Couleur:=Antichambre2Rouge
	End if 
End for 