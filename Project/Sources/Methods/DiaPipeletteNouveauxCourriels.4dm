//%attributes = {}
  // PipeletteNouveauxCourriels <- PipeletteTraitement <- ZPipelette
C_LONGINT:C283($FT;$Salé;$SFT;$Erreur;$Frais;$OuDuCochon;$SSFT)
$FT:=FT
$CDM:=Get 4D folder:C485(Dossier base:K5:14)+"Dossier Messages"+Séparateur dossier:K24:12
ARRAY LONGINT:C221(TbNM;0)  // initialisation du tableau des nom de message
ARRAY LONGINT:C221(TbMsgTaille;0)  // initialisation du tableau des nom de message
ARRAY TEXT:C222(TbID;0)  // initialisation du tableau des ID de message
$Erreur:=POP3_MsgLstInfo (RC;1;$FT;TbMsgTaille;TbNM;TbID)
  // transfert des $FT nouveaux fichiers
ARRAY TEXT:C222($TbIDNouveaux;0)
$FT:=Size of array:C274(TbID)
For ($Salé;1;$FT)
	$CDMCourant:=$CDM+TbID{$Salé}
	If (Test path name:C476($CDMCourant)<0)  // le message na pas encore été transféré 
		$Erreur:=POP3_Download (RC;TbNM{$Salé};0;$CDMCourant)
		If ($Erreur=0)
			APPEND TO ARRAY:C911($TbIDNouveaux;TbID{$Salé})
		End if 
	Else 
		$erreur:=POP3_Delete (RC;TbNM{$Salé};TbNM{$Salé})  // on retire le message du serveur   
	End if 
End for 

  // traitement des fichiers transférés
  // initialisé ici et traité dans CourrielEntrantSurveillance -> EnvoiCourrielAuServeurWeb
$FT:=Size of array:C274($TbIDNouveaux)
For ($Fumé;1;$FT)
	$ID:=$TbIDNouveaux{$Fumé}
	$CF:=$CDM+$ID
	valeurSujet:=""
	valeurDe:=""
	$Err:=POP3_Charset (1;1)
	$Erreur:=MSG_FindHeader ($CF;"subject:";valeurSujet)
	If (valeurSujet="@info asadia@")
		$Erreur:=MSG_FindHeader ($CF;"from:";valeurDe)
		ARRAY TEXT:C222($TbIDMessages;0)
		OB GET ARRAY:C1229([DiaData:45]XObjet:15;"IDMesRecAD";$TbIDMessages)
		ARRAY TEXT:C222($TbDeMessages;0)
		OB GET ARRAY:C1229([DiaData:45]XObjet:15;"DeMesRecAD";$TbDeMessages)
		If (Find in array:C230($TbIDMessages;$ID)<0)
			APPEND TO ARRAY:C911($TbIDMessages;$ID)
			OB SET ARRAY:C1227([DiaData:45]XObjet:15;"IDMesRecAD";$TbIDMessages)
			APPEND TO ARRAY:C911($TbDeMessages;valeurDe)
			OB SET ARRAY:C1227([DiaData:45]XObjet:15;"DeMesRecAD";$TbDeMessages)
			SAVE RECORD:C53([DiaData:45])
		End if 
	Else 
		$erreur:=POP3_Delete (RC;TbNM{$Salé};TbNM{$Salé})  // on retire le message du serveur   
	End if 
End for 
