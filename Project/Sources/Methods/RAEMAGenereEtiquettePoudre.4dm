//%attributes = {"shared":true}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 02/12/20, 11:07:20
  // ----------------------------------------------------
  // Méthode : RAEMAGenereEtiquettePoudre
  // Description
  // Génère les étiquette du RAEMA Poudre
  // Fonctionne avec le formulaire table EtiquetteRAEMAPoudre
  // ----------------------------------------------------

$CouleurVerte:="#01ED4C"
$CouleurRouge:="#FE0105"
$CouleurBleue:="#01CFFE"
$CouleurJaune:="#FEF201"
$CouleurBlanc:="#000000"

ARRAY TEXT:C222(TbSérie1Vert;0)
ARRAY TEXT:C222(TbSérie2Vert;0)
ARRAY TEXT:C222(TbSérie3Vert;0)
ARRAY TEXT:C222(TbSérie4Vert;0)
ARRAY TEXT:C222(TbSérie5Vert;0)

ARRAY TEXT:C222(TbSérie1Jaune;0)
ARRAY TEXT:C222(TbSérie2Jaune;0)
ARRAY TEXT:C222(TbSérie3Jaune;0)
ARRAY TEXT:C222(TbSérie4Jaune;0)
ARRAY TEXT:C222(TbSérie5Jaune;0)

ARRAY TEXT:C222(TbSérie1Bleu;0)
ARRAY TEXT:C222(TbSérie2Bleu;0)
ARRAY TEXT:C222(TbSérie3Bleu;0)
ARRAY TEXT:C222(TbSérie4Bleu;0)
ARRAY TEXT:C222(TbSérie5Bleu;0)

ARRAY TEXT:C222(TbSérie1Rouge;0)
ARRAY TEXT:C222(TbSérie2Rouge;0)
ARRAY TEXT:C222(TbSérie3Rouge;0)
ARRAY TEXT:C222(TbSérie4Rouge;0)
ARRAY TEXT:C222(TbSérie5Rouge;0)


ARRAY TEXT:C222(TbSérie1Blanc;0)
ARRAY TEXT:C222(TbSérie2Blanc;0)
ARRAY TEXT:C222(TbSérie3Blanc;0)
ARRAY TEXT:C222(TbSérie4Blanc;0)
ARRAY TEXT:C222(TbSérie5Blanc;0)

For ($salé;1;90)
	APPEND TO ARRAY:C911(TbSérie1Blanc;TbNumEchRaema1{$salé})
	APPEND TO ARRAY:C911(TbSérie2Blanc;TbNumEchRaema2{$salé})
	APPEND TO ARRAY:C911(TbSérie3Blanc;TbNumEchRaema3{$salé})
	APPEND TO ARRAY:C911(TbSérie4Blanc;TbNumEchRaema4{$salé})
	APPEND TO ARRAY:C911(TbSérie5Blanc;TbNumEchRaema5{$salé})
End for 

For ($salé;91;180)
	APPEND TO ARRAY:C911(TbSérie1Jaune;TbNumEchRaema1{$salé})
	APPEND TO ARRAY:C911(TbSérie2Jaune;TbNumEchRaema2{$salé})
	APPEND TO ARRAY:C911(TbSérie3Jaune;TbNumEchRaema3{$salé})
	APPEND TO ARRAY:C911(TbSérie4Jaune;TbNumEchRaema4{$salé})
	APPEND TO ARRAY:C911(TbSérie5Jaune;TbNumEchRaema5{$salé})
End for 

For ($salé;181;270)
	APPEND TO ARRAY:C911(TbSérie1Vert;TbNumEchRaema1{$salé})
	APPEND TO ARRAY:C911(TbSérie2Vert;TbNumEchRaema2{$salé})
	APPEND TO ARRAY:C911(TbSérie3Vert;TbNumEchRaema3{$salé})
	APPEND TO ARRAY:C911(TbSérie4Vert;TbNumEchRaema4{$salé})
	APPEND TO ARRAY:C911(TbSérie5Vert;TbNumEchRaema5{$salé})
End for 

For ($salé;271;360)
	APPEND TO ARRAY:C911(TbSérie1Bleu;TbNumEchRaema1{$salé})
	APPEND TO ARRAY:C911(TbSérie2Bleu;TbNumEchRaema2{$salé})
	APPEND TO ARRAY:C911(TbSérie3Bleu;TbNumEchRaema3{$salé})
	APPEND TO ARRAY:C911(TbSérie4Bleu;TbNumEchRaema4{$salé})
	APPEND TO ARRAY:C911(TbSérie5Bleu;TbNumEchRaema5{$salé})
End for 

For ($salé;361;450)
	APPEND TO ARRAY:C911(TbSérie1Rouge;TbNumEchRaema1{$salé})
	APPEND TO ARRAY:C911(TbSérie2Rouge;TbNumEchRaema2{$salé})
	APPEND TO ARRAY:C911(TbSérie3Rouge;TbNumEchRaema3{$salé})
	APPEND TO ARRAY:C911(TbSérie4Rouge;TbNumEchRaema4{$salé})
	APPEND TO ARRAY:C911(TbSérie5Rouge;TbNumEchRaema5{$salé})
End for 

  //LECTURE ÉCRITURE([RAEMANumEch])
QUERY:C277([RAEMANumEch:47];[RAEMANumEch:47]NumCampagne:5=[RAEMACampagnes:20]NumCampagne:2)
  //SUPPRIMER SÉLECTION([RAEMANumEch])
  //SÉLECTION VERS TABLEAU([RAEMANumEch];$TbNumEch)
  //$TT:=Taille tableau($TbNumEch)
$VarNumCampagne:=[RAEMACampagnes:20]NumCampagne:2
ARRAY TEXT:C222($TbNumCampagne;0)
ARRAY TEXT:C222($TbCouleur;0)
ARRAY TEXT:C222($TbNumEch;0)
ARRAY INTEGER:C220($TbNumOrdre;0)
ARRAY TEXT:C222($TbUUIDCampagne;0)

For ($Fumé;1;5)  // Une fois par série
	For ($salé;1;450)
		$Ordre:=($salé+(($fumé)-1*450))
		
		Case of 
			: ($salé<=90)
				$TbSérieBlanc:=Get pointer:C304("TbSérie"+String:C10($fumé)+"Blanc")
				VarNumEch:=$TbSérieBlanc->{$salé}
				$Couleur:=$CouleurBlanc
				
				APPEND TO ARRAY:C911($TbNumCampagne;[RAEMACampagnes:20]NumCampagne:2)
				APPEND TO ARRAY:C911($TbCouleur;$Couleur)
				APPEND TO ARRAY:C911($TbNumEch;VarNumEch)
				APPEND TO ARRAY:C911($TbNumOrdre;$Ordre)
				APPEND TO ARRAY:C911($TbUUIDCampagne;[RAEMACampagnes:20]UUID:1)
				
				
			: ($salé<=180)
				$TbSérieJaune:=Get pointer:C304("TbSérie"+String:C10($fumé)+"Jaune")
				VarNumEch:=$TbSérieJaune->{$salé-90}
				$Couleur:=$CouleurJaune
				
				APPEND TO ARRAY:C911($TbNumCampagne;[RAEMACampagnes:20]NumCampagne:2)
				APPEND TO ARRAY:C911($TbCouleur;$Couleur)
				APPEND TO ARRAY:C911($TbNumEch;VarNumEch)
				APPEND TO ARRAY:C911($TbNumOrdre;$Ordre)
				APPEND TO ARRAY:C911($TbUUIDCampagne;[RAEMACampagnes:20]UUID:1)
				
				
			: ($salé<=270)
				$TbSérieVert:=Get pointer:C304("TbSérie"+String:C10($fumé)+"Vert")
				VarNumEch:=$TbSérieVert->{$salé-180}
				$Couleur:=$CouleurVerte
				
				APPEND TO ARRAY:C911($TbNumCampagne;[RAEMACampagnes:20]NumCampagne:2)
				APPEND TO ARRAY:C911($TbCouleur;$Couleur)
				APPEND TO ARRAY:C911($TbNumEch;VarNumEch)
				APPEND TO ARRAY:C911($TbNumOrdre;$Ordre)
				APPEND TO ARRAY:C911($TbUUIDCampagne;[RAEMACampagnes:20]UUID:1)
				
				
			: ($salé<=360)
				$TbSérieBleu:=Get pointer:C304("TbSérie"+String:C10($fumé)+"Bleu")
				VarNumEch:=$TbSérieBleu->{$salé-270}
				$Couleur:=$CouleurBleue
				
				APPEND TO ARRAY:C911($TbNumCampagne;[RAEMACampagnes:20]NumCampagne:2)
				APPEND TO ARRAY:C911($TbCouleur;$Couleur)
				APPEND TO ARRAY:C911($TbNumEch;VarNumEch)
				APPEND TO ARRAY:C911($TbNumOrdre;$Ordre)
				APPEND TO ARRAY:C911($TbUUIDCampagne;[RAEMACampagnes:20]UUID:1)
				
				
				
			: ($salé<=450)
				$TbSérieRouge:=Get pointer:C304("TbSérie"+String:C10($fumé)+"Rouge")
				VarNumEch:=$TbSérieRouge->{$salé-360}
				$Couleur:=$CouleurRouge
				
				APPEND TO ARRAY:C911($TbNumCampagne;[RAEMACampagnes:20]NumCampagne:2)
				APPEND TO ARRAY:C911($TbCouleur;$Couleur)
				APPEND TO ARRAY:C911($TbNumEch;VarNumEch)
				APPEND TO ARRAY:C911($TbNumOrdre;$Ordre)
				APPEND TO ARRAY:C911($TbUUIDCampagne;[RAEMACampagnes:20]UUID:1)
				
		End case 
	End for 
End for 

ARRAY TO SELECTION:C261($TbNumCampagne;[RAEMANumEch:47]NumCampagne:5;$TbCouleur;[RAEMANumEch:47]Couleur:4;$TbNumEch;[RAEMANumEch:47]NumEch:3;$TbNumOrdre;[RAEMANumEch:47]Ordre:6;$TbUUIDCampagne;[RAEMANumEch:47]UUIDCampagne:2)
  //LECTURE ÉCRITURE([RAEMANumEch])
  //CHERCHER([RAEMANumEch];[RAEMANumEch]NumCampagne=[RAEMACampagnes]NumCampagne)
  //$FT:=Enregistrements trouvés([RAEMANumEch])
  //Si ($FT>0)
  //Boucle ($Salé;1;$FT)
  //SUPPRIMER ENREGISTREMENT([RAEMANumEch])
  //ENREGISTREMENT SUIVANT([RAEMANumEch])
  //Fin de boucle 
  //Fin de si 

  //Boucle ($Fumé;1;5)  // Une fois par série
  //Boucle ($salé;1;450)
  //Au cas ou 
  //: ($salé<=90)
  //$TbSérieBlanc:=Pointeur vers("TbSérie"+Chaîne($fumé)+"Blanc")
  //VarNumEch:=$TbSérieBlanc->{$salé}
  //$Couleur:=$CouleurBlanc
  //CRÉER ENREGISTREMENT([RAEMANumEch])
  //[RAEMANumEch]NumCampagne:=[RAEMACampagnes]NumCampagne
  //[RAEMANumEch]Couleur:=$Couleur
  //[RAEMANumEch]NumEch:=VarNumEch
  //[RAEMANumEch]Ordre:=($salé+(($fumé)-1*450))
  //[RAEMANumEch]UUIDCampagne:=[RAEMACampagnes]UUID
  //STOCKER ENREGISTREMENT([RAEMANumEch])


  //: ($salé<=180)
  //$TbSérieJaune:=Pointeur vers("TbSérie"+Chaîne($fumé)+"Jaune")
  //VarNumEch:=$TbSérieJaune->{$salé-90}
  //$Couleur:=$CouleurJaune
  //CRÉER ENREGISTREMENT([RAEMANumEch])
  //[RAEMANumEch]NumCampagne:=[RAEMACampagnes]NumCampagne
  //[RAEMANumEch]Couleur:=$Couleur
  //[RAEMANumEch]NumEch:=VarNumEch
  //[RAEMANumEch]Ordre:=($salé+(($fumé)-1*450))
  //[RAEMANumEch]UUIDCampagne:=[RAEMACampagnes]UUID
  //STOCKER ENREGISTREMENT([RAEMANumEch])

  //: ($salé<=270)
  //$TbSérieVert:=Pointeur vers("TbSérie"+Chaîne($fumé)+"Vert")
  //VarNumEch:=$TbSérieVert->{$salé-180}
  //$Couleur:=$CouleurVerte
  //CRÉER ENREGISTREMENT([RAEMANumEch])
  //[RAEMANumEch]NumCampagne:=[RAEMACampagnes]NumCampagne
  //[RAEMANumEch]Couleur:=$Couleur
  //[RAEMANumEch]NumEch:=VarNumEch
  //[RAEMANumEch]Ordre:=($salé+(($fumé)-1*450))
  //[RAEMANumEch]UUIDCampagne:=[RAEMACampagnes]UUID
  //STOCKER ENREGISTREMENT([RAEMANumEch])

  //: ($salé<=360)
  //$TbSérieBleu:=Pointeur vers("TbSérie"+Chaîne($fumé)+"Bleu")
  //VarNumEch:=$TbSérieBleu->{$salé-270}
  //$Couleur:=$CouleurBleue
  //CRÉER ENREGISTREMENT([RAEMANumEch])
  //[RAEMANumEch]NumCampagne:=[RAEMACampagnes]NumCampagne
  //[RAEMANumEch]Couleur:=$Couleur
  //[RAEMANumEch]NumEch:=VarNumEch
  //[RAEMANumEch]Ordre:=($salé+(($fumé)-1*450))
  //[RAEMANumEch]UUIDCampagne:=[RAEMACampagnes]UUID
  //STOCKER ENREGISTREMENT([RAEMANumEch])

  //: ($salé<=450)
  //$TbSérieRouge:=Pointeur vers("TbSérie"+Chaîne($fumé)+"Rouge")
  //VarNumEch:=$TbSérieRouge->{$salé-360}
  //$Couleur:=$CouleurRouge
  //CRÉER ENREGISTREMENT([RAEMANumEch])
  //[RAEMANumEch]NumCampagne:=[RAEMACampagnes]NumCampagne
  //[RAEMANumEch]Couleur:=$Couleur
  //[RAEMANumEch]NumEch:=VarNumEch
  //[RAEMANumEch]Ordre:=($salé+(($fumé)-1*450))
  //[RAEMANumEch]UUIDCampagne:=[RAEMACampagnes]UUID
  //STOCKER ENREGISTREMENT([RAEMANumEch])
  //Fin de cas 
  //Fin de boucle 
  //Fin de boucle 

