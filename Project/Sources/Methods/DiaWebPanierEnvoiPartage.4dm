//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm
  // Date et heure : 28/08/18, 10:29:15
  // ----------------------------------------------------
  // Méthode : WebPanierEnvoiPartage
  // Description
  //
  //
  // Paramètre $1 = message AJAX du type "panierpartageF5014£destinataire@domaine.fr"
  //                où "F" désigne le français, 5014 = Numéro enregistrement([XDonnees])
  //                et destinataire@domaine.fr = adresse de login du destinataire
  // ----------------------------------------------------


C_LONGINT:C283($Salé;$FT)
$Mess:=$1
$Langue:=$Mess[[14]]
$Pos:=Position:C15("£";$Mess)
$NumEnrPanierN:=Num:C11(Substring:C12($Mess;1;($Pos-1)))
GOTO RECORD:C242([DiaData:45];$NumEnrPanierN)
$NomPanier:=[DiaData:45]XNom:1
$LoginPanierInitial:=[DiaData:45]XAlpha:14
$Login:=Replace string:C233(Substring:C12($Mess;($Pos+1));",";";")
$Login:=Replace string:C233($Login;" ";"")
If ($Login#"")
	ARRAY TEXT:C222($TbLoginEchange;0)
	ZTexteVersTableau ($Login;->$TbLoginEchange;";")
	
	  // l'utilisateur d'AsaDia existe t'il ?
	C_TEXT:C284($Ligne)
	$Chem:=Data file:C490
	$Pos1:=Position:C15(":";$Chem)
	$Reste:=Substring:C12($Chem;($pos1+1))
	$Pos2:=Position:C15(":";$Reste)
	$Reste:=Substring:C12($Reste;($pos2+1))
	$Pos3:=Position:C15(":";$Reste)
	$Base:=Substring:C12($Chem;1;($Pos1+$Pos2+$Pos3))
	$FichierAsaDia2:=$Base+"Dropbox:Asadia:asadia2.txt"
	If (Test path name:C476($FichierAsaDia2)=Est un document:K24:1)
		$Doc:=Open document:C264($FichierAsaDia2;Mode lecture:K24:5)
		If (OK=1)
			ARRAY TEXT:C222($TbLoginExistant;0)
			RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)  // première ligne = ET
			C_TEXT:C284(Col1;Col2;Col3;Col4;Col5;Col6;Col7;Col4;0)
			ARRAY TEXT:C222(TbUtilAD2EnvoiMail;0)
			RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)  //  ligne suivante
			$Trouve:=False:C215  // pessimiste avec ça
			Repeat 
				APPEND TO ARRAY:C911($TbLoginExistant;DiaImportExtraitColonne )  //  on ajoute l'adresse mail existante
				RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)  //  ligne suivante
			Until ((Ligne="") | $Trouve)
		End if 
		CLOSE DOCUMENT:C267($Doc)
	End if 
	  // Intéressons nous au contenu envoyé
	$FT:=Size of array:C274($TbLoginEchange)
	For ($Salé;1;$FT)
		$Rang:=$FT-$Salé+1
		$AdresseCourante:=$TbLoginEchange{$Rang}
		If (Find in array:C230($TbLoginExistant;$AdresseCourante)>0)
			DELETE FROM ARRAY:C228($TbLoginEchange;$Rang)
			  // recherche des paniers du destinataire pour éviter les conflits de nom et d'initiales
			QUERY:C277([DiaData:45];[DiaData:45]XEntier:2=1951;*)
			QUERY:C277([DiaData:45]; & [DiaData:45]XAlpha:14=$AdresseCourante)
			SELECTION TO ARRAY:C260([DiaData:45]XNom:1;$TbNom\
				;[DiaData:45]XType:5;$TbInitiales)
			
			  // plaçons-nous sur le panier
			GOTO RECORD:C242([DiaData:45];$NumEnrPanierN)
			$NomPanierInitial:=[DiaData:45]XNom:1
			$Index:=" ("+[DiaData:45]XType:5+")"
			$NomPanierEnvoyé:=[DiaData:45]XNom:1+$Index
			$LongueurNomPanier:=Length:C16($NomPanierEnvoyé)
			If ($LongueurNomPanier>30)  // Conflit de longueur
				$FinTexte:=13+($LongueurNomPanier-30)+4  // 10 caractères + "..." =13, $LongueurNomPanier-30 = raccourcissement minimum, 4= marge pour indices,
				$NomPanierEnvoyé:=Substring:C12($NomPanierEnvoyé;1;10)+"..."+Substring:C12($NomPanierEnvoyé;$FinTexte)
			End if 
			If (Find in array:C230($TbNom;[DiaData:45]XNom:1)>0)  // conflit de nom
				$Compteur:=1
				If ($LoginPanierInitial=$AdresseCourante)  // On se contente d'indicer le nom du panier
					Repeat 
						$NomPanier:=$NomPanierInitial+String:C10($Compteur)
						$Compteur:=$Compteur+1
					Until (Find in array:C230($TbNom;$NomPanier)<0)
				Else 
					Repeat 
						$NomPanier:=$NomPanierEnvoyé+String:C10($Compteur)
						$Compteur:=$Compteur+1
					Until (Find in array:C230($TbNom;$NomPanier)<0)
				End if 
			End if 
			
			DUPLICATE RECORD:C225([DiaData:45])
			[DiaData:45]ID:12:=Generate UUID:C1066
			
			[DiaData:45]XNom:1:=$NomPanier
			[DiaData:45]XDate:3:=Current date:C33
			[DiaData:45]XHeure:13:=Current time:C178
			[DiaData:45]XAlpha:14:=$AdresseCourante  // attribution au destinataire
			SAVE RECORD:C53([DiaData:45])
		End if 
	End for 
	$SFT:=Size of array:C274($TbLoginEchange)
	$NbAdresses:=(Num:C11($FT>1)*(DiaWebTraduitTexte ("à toutes adresses";$Langue)))+(Num:C11($FT=1)*(DiaWebTraduitTexte ("à l'adresse";$Langue)))+" "
	If ($SFT=0)  // toutes les adresses sont OK
		$s:=(Num:C11(($FT>1) & ($Langue="F"))*"s")
		$Envoi:=DiaWebTraduitTexte ("Le panier";$Langue)+" "+<>ZGuil+$NomPanier+<>ZGuil+" "+DiaWebTraduitTexte ("a été envoyé";$Langue)+" "
		$Envoi:=$Envoi+$NbAdresses+DiaWebTraduitTexte ("indiquée";$Langue)+$s+"."
	Else 
		$Envoi:=DiaWebTraduitTexte ("Le panier";$Langue)+" "+<>ZGuil+$NomPanier+<>ZGuil+" "+DiaWebTraduitTexte ("n'a pas été envoyé";$Langue)+" "
		$Envoi:=$Envoi+$NbAdresses+ZTableauVersTexte (->$TbLoginEchange;", ")+"."
	End if 
Else 
	$Envoi:=DiaWebTraduitTexte ("Le panier";$Langue)+" "+<>ZGuil+$NomPanier+<>ZGuil+" "+DiaWebTraduitTexte ("n'a pas été envoyé car aucune adresse";$Langue)+"."
End if 


WEB SEND TEXT:C677($Envoi)