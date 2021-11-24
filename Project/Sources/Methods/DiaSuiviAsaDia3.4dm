//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Claude
// Date et heure : 13/06/13, 10:11:46
// ----------------------------------------------------
// Méthode : SuiviAsaDia2
// Description
//
//
// Paramètres
// ----------------------------------------------------

C_LONGINT:C283($Salé; $FT; $NbA; $NbL; $NbN; $NbT; $NbInscrit; $Pos1; $Pos2; $Pos3; $TT)
C_TEXT:C284($Ligne)
$Chem:=Data file:C490
$Pos1:=Position:C15(":"; $Chem)
$Reste:=Substring:C12($Chem; ($pos1+1))
$Pos2:=Position:C15(":"; $Reste)
$Reste:=Substring:C12($Reste; ($pos2+1))
$Pos3:=Position:C15(":"; $Reste)
$Base:=Substring:C12($Chem; 1; ($Pos1+$Pos2+$Pos3))
$FichierAsaDia2:=$Base+"Dropbox:Asadia:asadia2.txt"
If (Test path name:C476($FichierAsaDia2)=Est un document:K24:1)
	$Doc:=Open document:C264($FichierAsaDia2; Mode lecture:K24:5)
	If (OK=1)
		RECEIVE PACKET:C104($Doc; $Ligne; <>ZCR)  // première ligne = ET
		C_TEXT:C284(Col1; Col2; Col3; Col4; Col5; Col6; Col7; Col4; 0)
		$NbInscrit:=1  // cgm non décompté par la suite
		$NbEt:=0
		// Les présents
		$NbA:=0  // Alfort
		$NbB:=0  // Belges
		$NbL:=0  // Lyon
		$NbN:=0  // Nantes
		$NbT:=0  // Toulouse
		$NbDGAL:=0  // DGAL
		
		// Les enregistrés
		$NbEtr:=0
		$NbAr:=0
		$NbBr:=0
		$NbLr:=0
		$NbNr:=0
		$NbTr:=0
		$NbDGALr:=0
		
		$NbDif:=1
		$NbDifr:=1
		$NbLimite:=0
		$NbEnr:=0
		ARRAY TEXT:C222(TbUtilAD2EnvoiMail; 0)
		$NomLimite:=""
		ARRAY TEXT:C222($TbNomDep; 0)
		ARRAY TEXT:C222($TbNomAb; 0)
		ARRAY LONGINT:C221($TbNbreDep; 0)
		ARRAY LONGINT:C221($TbNbreCon; 0)
		ARRAY LONGINT:C221($TbNbreAb; 0)
		RECEIVE PACKET:C104($Doc; Ligne; <>ZCR)  //  ligne suivante
		Repeat 
			If (Ligne#"")
				// 1 ligne = 5 colonnes : 1=mail asa, 2=Nb de licence
				// 3=type de licence,  4=nbre de licence(s) utilisée(s)
				// 5=Adresse de récup
				Col1:=DiaImportExtraitColonne
				Col2:=DiaImportExtraitColonne
				Col3:=DiaImportExtraitColonne
				Col4:=DiaImportExtraitColonne
				Col5:=Ligne
				If (Col1#"@cegeheme@")  // inutile de compter les cgm
					$NbInscrit:=$NbInscrit+1
					Case of 
						: (Col1="@student.ulg.ac.be") & (Col3="@soire@")
							$NbB:=$NbB+1
							If (Num:C11(Col4)>0)
								$NbBr:=$NbBr+1
							End if 
							
						: (Col1="@alfort@") & (Col3="@soire@")
							$NbA:=$NbA+1
							If (Num:C11(Col4)>0)
								$NbAr:=$NbAr+1
							End if 
							
						: (Col1="@vetagro@") & (Col3="@soire@")
							$NbL:=$NbL+1
							If (Num:C11(Col4)>0)
								$NbLr:=$NbLr+1
							End if 
							
						: (Col1="@envt@") & (Col3="@soire@")
							$NbT:=$NbT+1
							If (Num:C11(Col4)>0)
								$NbTr:=$NbTr+1
							End if 
							
						: (Col1="@oniris@") & (Col3="@soire@")
							$NbN:=$NbN+1
							If (Num:C11(Col4)>0)
								$NbNr:=$NbNr+1
							End if 
							
						: (Col1="@.gouv.fr")
							$NbDGAL:=$NbDGAL+1
							If (Num:C11(Col4)>0)
								$NbDGALr:=$NbDGALr+Num:C11(Col4)
							End if 
							$Pos:=Position:C15("@"; Col1)
							$Pos2:=Position:C15(".gouv.fr"; Col1)
							$Dep:=Substring:C12(Col1; ($Pos+1); ($Pos2-$Pos-1))
							$L:=Find in array:C230($TbNomDep; $Dep)
							If ($L>0)
								$TbNbreCon{$L}:=$TbNbreCon{$L}+Num:C11(Col4)
								$TbNbreDep{$L}:=$TbNbreDep{$L}+1
							Else 
								APPEND TO ARRAY:C911($TbNomDep; $Dep)
								APPEND TO ARRAY:C911($TbNbreCon; Num:C11(Col4))
								APPEND TO ARRAY:C911($TbNbreDep; 1)
							End if 
							
							
						Else 
							$NbDif:=$NbDif+1
							If (Num:C11(Col4)>0)
								$NbDifr:=$NbDifr+1
							End if 
							
							
					End case 
					
					
					If (Num:C11(Col2)<=Num:C11(Col4)) & (Col3="provisoire")
						$NbLimite:=$NbLimite+1
						$NomLimite:=$NomLimite+", "+Col1
					End if 
					
					If (Num:C11(Col4)>0)
						$NbEnr:=$NbEnr+1
						//TABLEAU TEXTE(TbUtilAD2M;0)
						//TABLEAU DATE(TbUtilAD2D;0)
						//CHERCHER([XDonnées];[XDonnées]XNom="AsaDia2";*)
						//CHERCHER([XDonnées]; & [XDonnées]XType="AsaDia2")
						//Si (Enregistrements trouves([XDonnées])=0)
						//CREER ENREGISTREMENT([XDonnées])
						//[XDonnées]XNom:="AsaDia2"
						//[XDonnées]XType:="AsaDia2"
						//ZVariableVersblob (->[XDonnées]XBlob;->TbUtilAD2M;->TbUtilAD2D)
						//STOCKER ENREGISTREMENT([XDonnées])
						//Fin de si
					End if 
					// ZBlobVersVariable (->[XDonnées]XBlob;->TbUtilAD2M;->TbUtilAD2D)
					//$L:=Chercher dans tableau(TbUtilAD2M;Col6)
					//$L2:=Chercher dans tableau(TbUtilAD2EnvoiMail;Col6)
					//Si ($L<0) & ($L2<0) & (Col6#"")
					//AJOUTER A TABLEAU(TbUtilAD2EnvoiMail;Col6)
					//Sinon
					//Si (($L>0) & (Col6#"") & ($L2<0))
					//Si (TbUtilAD2D{$L}>(Date du jour-30))
					//AJOUTER A TABLEAU(TbUtilAD2EnvoiMail;Col6)
					//Fin de si
					//Fin de si
					//Fin de si
				End if 
			End if 
			RECEIVE PACKET:C104($Doc; Ligne; <>ZCR)  //  ligne suivante
			
		Until (Ligne="")
	End if 
	CLOSE DOCUMENT:C267($Doc)
	$Mess:="Sur "+String:C10($NbInscrit)+" inscrits sur le site de l'ASA :"+<>ZCR
	$Mess:=$Mess+String:C10($NbA)+" pour Alfort dont "+String:C10($NbAr)+" enregistrés;"+<>ZCR
	$Mess:=$Mess+String:C10($NbL)+" pour Lyon dont "+String:C10($NbLr)+" enregistrés;"+<>ZCR
	$Mess:=$Mess+String:C10($NbN)+" pour Nantes dont "+String:C10($NbNr)+" enregistrés;"+<>ZCR
	$Mess:=$Mess+String:C10($NbT)+" pour Toulouse dont "+String:C10($NbTr)+" enregistrés;"+<>ZCR
	$Mess:=$Mess+String:C10($NbB)+" pour ULG dont "+String:C10($NbBr)+" enregistrés;"+<>ZCR
	$Mess:=$Mess+String:C10($NbDGAL)+" pour la DGAL dont "+String:C10($NbDGALr)+" enregistrés;"+<>ZCR
	$Mess:=$Mess+"Détail des départements : "+<>ZCR
	$TT:=Size of array:C274($TbNomDep)
	SORT ARRAY:C229($TbNomDep; $TbNbreDep; $TbNbreCon; >)
	For ($Salé; 1; $TT)
		
		Case of 
			: ($TbNbreCon{$Salé}=0)
				$Inst:="Aucune installation"
				
			: ($TbNbreCon{$Salé}=0)
				$Inst:="Une seule installation"
				
			Else 
				$Inst:=String:C10($TbNbreCon{$Salé})
				
		End case 
		$s:=Num:C11($TbNbreDep{$Salé}>1)*"s"
		$Mess:=$Mess+$TbNomDep{$Salé}+" : "+$Inst+" pour "\
			+String:C10($TbNbreDep{$Salé})+" adresse"+$s+" mail"+<>ZCR
	End for 
	
	$Mess:=$Mess+String:C10($NbDif)+" autres dont "+String:C10($NbDifr)+" enregistrés."+<>ZCR
	$Mess:=$Mess+"soit "+String:C10($NbEnr)+" enregistrés en tout."+<>ZCR
	
	If ($NbLimite>0)
		$s:=(Num:C11($NbLimite>1)*" inscrits provisoires ont")+(Num:C11($NbLimite>1)*" inscrit provisoire a")
		$Mess:=$Mess+<>ZCR+"ATTENTION, "+String:C10($NbLimite)+$s+" atteint la limite..."+<>ZCR
		$Mess:=$Mess+Substring:C12($NomLimite; 3)
	End if 
	
	C_LONGINT:C283($Salé; $FT)
	$Deb:=Date:C102("01/01/2018")
	QUERY:C277([DiaData:45]; [DiaData:45]XType:5="Wad3"; *)
	QUERY:C277([DiaData:45]; [DiaData:45]XDate:3>$Deb)
	SELECTION TO ARRAY:C260([DiaData:45]XNom:1; $TbLogin; [DiaData:45]XDate:3; $TbDate)
	SORT ARRAY:C229($TbDate; $TbLogin; >)
	$FT:=Size of array:C274($TbDate)
	$Mess:=$Mess+<>ZCR2+"Fréquentation Web"+<>ZCR
	$Compteur:=1
	ARRAY TEXT:C222($TbVisiteur; 8)
	$TbVisiteur{1}:="Abattoirs"
	$TbVisiteur{2}:="ENVA"
	$TbVisiteur{3}:="ENVL"
	$TbVisiteur{4}:="ENVN"
	$TbVisiteur{5}:="ENVT"
	$TbVisiteur{6}:="ULG"
	$TbVisiteur{7}:="CGM"
	$TbVisiteur{8}:="Autres"
	Repeat 
		ARRAY LONGINT:C221($TbOccurence; 0)
		ARRAY LONGINT:C221($TbOccurence; 8)
		
		$Mois:=Month of:C24($TbDate{$Compteur})
		$OC:=True:C214
		While ($OC)
			$login:=$TbLogin{$Compteur}
			Case of 
				: ($login="@gouv.fr")
					$visiteur:="Abattoirs"
					
				: ($login="@alfort.fr")
					$visiteur:="ENVA"
					
				: ($login="@vetagro-sup.fr")
					$visiteur:="ENVL"
					
				: ($login="@oniris-nantes.fr")
					$visiteur:="ENVN"
					
				: ($login="@envt.fr")
					$visiteur:="ENVT"
					
				: ($login="@ulg.ac.be") | ($login="ulg")
					$visiteur:="ULG"
					
				: ($login="cegeheme@wanadoo.fr")
					$visiteur:="CGM"
					
				Else 
					$visiteur:="Autres"
					
			End case 
			$L:=Find in array:C230($TbVisiteur; $visiteur)
			$TbOccurence{$L}:=$TbOccurence{$L}+1
			$Compteur:=$Compteur+1
			If ($Compteur<=$FT)
				$OC:=($Mois=Month of:C24($TbDate{$Compteur}))
			Else 
				$OC:=False:C215
			End if 
		End while 
		$Mess:=$Mess+<>ZTbNomDuMois{$Mois}+<>ZCR2
		For ($salé; 1; 8)
			$Mess:=$Mess+$TbVisiteur{$Salé}+<>ZTab+String:C10($TbOccurence{$Salé})+<>ZCR
		End for 
		$Mess:=$Mess+<>ZCR
	Until ($Mois=Month of:C24(Current date:C33))
	
	// A revoir // Modifié par : iMacASA2017 (13/04/2019)
	//  $Mess:=$Mess+Ad3DecomptePistePhotos
	
	$Mess:=$Mess+<>ZCR2+"Liste des espions constatés"+<>ZCR+DiaSpy
	
	
	$Objet:="Avancement de l'utilisation d'AsaDia 2"
	$Corps:="Chers Tous,"+<>ZCR+<>ZCR+"Une nouvelle inscription a eu lieu."+<>ZCR
	$Corps:=$Corps+"Veuillez trouver ci-dessous l'avancement de l'utilisation d'AsaDia2"
	$Corps:=$Corps+<>ZCR+$Mess+<>ZCR+"Bien cordialement."+<>ZCR
	$Corps:=$Corps+"--"+<>ZCR+"L'équipe de l'ASA"+<>ZCR+"email : asa-spv@wanadoo.fr"+<>ZCR+"Portable : 06 07 97 96 21"
	// FIXER TEXTE DANS CONTENEUR($Corps)
	//ChercheDonneesCourielSortant($Corps)
	//TABLEAU TEXTE(TbMailMAJC;0)
	//AJOUTER A TABLEAU(TbMailMAJC;"vcarlier@vet-alfort.fr")
	//AJOUTER A TABLEAU(TbMailMAJC;"pierre.demont@vetagro-sup.fr")
	//AJOUTER A TABLEAU(TbMailMAJC;"jean-michel.cappelier@oniris-nantes.fr")
	//AJOUTER A TABLEAU(TbMailMAJC;"h.brugere@envt.fr")
	//AJOUTER A TABLEAU(TbMailMAJC;"chevalier-rna@orange.fr")
	//AJOUTER A TABLEAU(TbMailMAJC;"michel.mas@ensv.vetagro-sup.fr")
	//$OK:=EnvoiMailDiscret([XDonnées]XTexte;"asa-spv@wanadoo.fr";$Corps;"cegeheme@wanadoo.fr";->TbMailMAJC;$Objet)
	
	$Objet:="Information en retour de l'utilisation d'AsaDia 2"
	$Corps:="Chers Utilisateurs d'AsaDia 2,"+<>ZCR+<>ZCR
	$Corps:=$Corps+"Ce mail pour vous informer que nous avons installé, "\
		+"sur le site de l’ASA(<http:  //www.asa-spv.asso.fr/> )"\
		+" un système de retour concernant l’utilisation d’AsaDia 2."+<>ZCR+<>ZCR
	$Corps:=$Corps+"Il suffit de cliquer sur le lien “Améliorer AsaDia 2” en page d’accueil"\
		+" pour y avoir accès"+<>ZCR+<>ZCR
	
	$Corps:=$Corps+"N’hésitez pas à l’utiliser pour nous signaler une erreur, "\
		+"un problème de fonctionnement ou pour proposer une amélioration."+<>ZCR+<>ZCR
	
	$Corps:=$Corps+"Bien à Vous."+<>ZCR+"--"+<>ZCR+"L'équipe de l’ASA"+<>ZCR\
		+"(Association Animal Société Aliment)"+<>ZCR
	
	$Corps:=$Corps+<>ZCR+"Bâtiment Jean GIRARD - Ecole Nationale Vétérinaire d'Alfort"+<>ZCR\
		+"7, avenue du Général De Gaulle-94704 Maisons-Alfort Cedex"\
		+<>ZCR+"Téléphone et fax : 01 56 29 36 30"+<>ZCR+"e-mail : asa-spv@wanadoo.fr"\
		+<>ZCR+"Portable : 06 07 97 96 21"
	//AsaDia2MailInfo
	
End if 