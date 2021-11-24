//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 10/12/19, 04:25:27
  // ----------------------------------------------------
  // Méthode : DiaWebScruteListeLicences
  // Description
  //   Méthode qui scrute le fichier asadia2.txt
  //   de la dropbox du serveur et place le résultat dans
  //   la [XDonnees] de type "LicenceAsaDia" et de nom Licence ""AsaDia"
  // ----------------------------------------------------
C_TEXT:C284($Ligne)

  // récupération des logins existants
ALL RECORDS:C47([DiaUtilisateurs:14])
SELECTION TO ARRAY:C260([DiaUtilisateurs:14]EmailASA:12;$TbEmailASA)

  // Recherche de la [DiaData] qui contient les renseignements sur le fichier
QUERY:C277([DiaData:45];[DiaData:45]XNom:1="Licence AsaDia";*)
QUERY:C277([DiaData:45]; & [DiaData:45]XType:5="LicenceAsaDia")
If (Records in selection:C76([DiaData:45])=0)
	CREATE RECORD:C68([DiaData:45])
	[DiaData:45]XNom:1:="Licence AsaDia"
	[DiaData:45]XType:5:="LicenceAsaDia"
End if 
$DernièreTaille:=[DiaData:45]XEntier:2
$NumEnrDiaData:=Record number:C243([DiaData:45])  // permet des chercher dans la table de [DiaData]


  // recherche du fichier des licences

$Chem:=ZDocNomFichier (System folder:C487(Bureau:K41:16);1)
$FichierAsaDia2:=$Chem+"Dropbox"+Séparateur dossier:K24:12+"Asadia"+Séparateur dossier:K24:12+"Asadia2.txt"
If (Test path name:C476($FichierAsaDia2)=Est un document:K24:1)  // Y est-il ??
	$TailleDoc:=Get document size:C479($FichierAsaDia2)  // Oui : on regarde si sa taille a changé
	If ($TailleDoc#$DernièreTaille)
		$Doc:=Open document:C264($FichierAsaDia2;Mode lecture:K24:5)  // on l'ouvre pour actualiser [DiaUtilisateurs]
		If (OK=1)  // C'est fait
			RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)  // première ligne = ET
			C_TEXT:C284(Col1;Col2;Col3;Col4;Col5;Col6;Col7;Col4;0)
			ARRAY TEXT:C222($TbNomLoginAsaDia;0)  // Tableau des login
			RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)  //  ligne suivante
			Ligne:=Replace string:C233(Ligne;Char:C90(10);"")
			$Trouve:=False:C215  // pessimiste avec ça
			While (Ligne#"")
				$Login:=DiaImportExtraitColonne 
				$L:=Find in array:C230($TbEmailASA;$Login)
				If ($L<0)  // Il n'existe pas, il faut donc le créer
					CREATE RECORD:C68([DiaUtilisateurs:14])
					[DiaUtilisateurs:14]EmailASA:12:=$Login
					DiaImportExtraitColonne 
					[DiaUtilisateurs:14]TypeVersion:10:=DiaImportExtraitColonne 
					$PeuAssidu:=False:C215
					QUERY:C277([DiaData:45];[DiaData:45]XNom:1=$Login;*)
					QUERY:C277([DiaData:45]; & [DiaData:45]XType:5="WAd3")
					If (Records in selection:C76([DiaData:45])>0)  // tenir compte des assidus
						SELECTION TO ARRAY:C260([DiaData:45]XDate:3;$TbDate)
						SORT ARRAY:C229($TbDate;<)
						$Delta:=Current date:C33-$TbDate{1}
						If ($Delta<500)  // Il s'est logué depuis 500 jours
							$PeuAssidu:=True:C214
						End if 
					Else   // peu assidu
						$PeuAssidu:=True:C214
					End if 
					[DiaUtilisateurs:14]Caduc:13:=$PeuAssidu
					SAVE RECORD:C53([DiaUtilisateurs:14])
					APPEND TO ARRAY:C911($TbEmailASA;$Login)
				End if 
				RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)  //  ligne suivante
				Ligne:=Replace string:C233(Ligne;Char:C90(10);"")
			End while 
		End if 
		CLOSE DOCUMENT:C267($Doc)
		READ WRITE:C146([DiaData:45])
		GOTO RECORD:C242([DiaData:45];$NumEnrDiaData)
		[DiaData:45]XEntier:2:=$TailleDoc
		SAVE RECORD:C53([DiaData:45])
		ZAmnistiePartielle (->[DiaData:45];True:C214)
		
		ALL RECORDS:C47([DiaUtilisateurs:14])
		SELECTION TO ARRAY:C260([DiaUtilisateurs:14]EmailASA:12;<>TbNomLoginAsaDia)  // Tableau des login
	End if 
	
Else   // le fichier asadia2.txt a disparu !!!
	SELECTION TO ARRAY:C260([DiaUtilisateurs:14]Caduc:13;$TbCaduc;[DiaUtilisateurs:14]TypeVersion:10;$TypeVersion)
	$Texte:=""
	For ($Salé;1;$FT)
		$Texte:=$Texte+$TbEmailASA{$Salé}+<>ZTab+$TypeVersion{$Salé}+<>ZTab+String:C10($TbCaduc{$Salé})+<>ZCR
	End for 
	$Doc:=Create document:C266($FichierAsaDia2)
	If (OK=1)
		SEND PACKET:C103($Doc;$Texte)
		CLOSE DOCUMENT:C267($Doc)
	End if 
End if 
