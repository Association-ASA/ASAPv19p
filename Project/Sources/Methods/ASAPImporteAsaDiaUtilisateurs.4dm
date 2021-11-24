//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 24/12/18, 17:51:54
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPImporteAsaDiaUtilisateurs
  // Description
  // 

$Doc:=Open document:C264("";Mode lecture:K24:5)
If (OK=1)
	RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
	If ($Ligne#"ExportAsaDiaUtilisateurs@")
		ALERT:C41("Désolé, ce fichier ne semble pas être un fichier d'exportation d'Utilisateurs d'AsaDia...")
	Else 
		RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)  // ligne 2 = ET des tableaux
		RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)  // ligne 3 = Ligne valeur 1
		Repeat 
			$Pos:=Position:C15(<>ZTab;$Ligne)  // ID Utilisateur = ignoré
			$Ligne:=Substring:C12($Ligne;($Pos+1))
			
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$NomUtilisateur:=Substring:C12($Ligne;1;($Pos-1))
			$Ligne:=Substring:C12($Ligne;($Pos+1))
			
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$AdresseUtilisateur:=Substring:C12($Ligne;1;($Pos-1))
			$Ligne:=Substring:C12($Ligne;($Pos+1))
			
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$NbUtilisationA:=Substring:C12($Ligne;1;($Pos-1))
			$NbUtilisationN:=Num:C11($NbUtilisationA)
			$Ligne:=Substring:C12($Ligne;($Pos+1))
			
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$EMailUtilisateurA:=Substring:C12($Ligne;1;($Pos-1))
			$Ligne:=Substring:C12($Ligne;($Pos+1))
			
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$DateEnregistrementA:=Substring:C12($Ligne;1;($Pos-1))
			$DateEnregistrementD:=Date:C102($DateEnregistrementA)
			$Ligne:=Substring:C12($Ligne;($Pos+1))
			
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$TexteEnregistrement:=Substring:C12($Ligne;1;($Pos-1))
			$Ligne:=Substring:C12($Ligne;($Pos+1))
			
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$MailEnvoiOKA:=Substring:C12($Ligne;1;($Pos-1))
			$MailEnvoiOKB:=($MailEnvoiOKA="vrai")
			$Ligne:=Substring:C12($Ligne;($Pos+1))
			
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$TypeVersion:=Substring:C12($Ligne;1;($Pos-1))
			$Ligne:=Substring:C12($Ligne;($Pos+1))
			
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$NbreLicenceA:=Substring:C12($Ligne;1;($Pos-1))
			$NbreLicenceN:=Num:C11($NbreLicenceA)
			$Ligne:=Substring:C12($Ligne;($Pos+1))
			
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$CodeUtilisateur:=Substring:C12($Ligne;1;($Pos-1))
			$Ligne:=Substring:C12($Ligne;($Pos+1))
			
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$EmailASA:=Substring:C12($Ligne;1;($Pos-1))
			$Ligne:=Substring:C12($Ligne;($Pos+1))
			
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$CaducA:=Substring:C12($Ligne;1;($Pos-1))
			$CaducB:=($CaducA="vrai")
			
			READ WRITE:C146([DiaUtilisateurs:14])
			QUERY:C277([DiaUtilisateurs:14];[DiaUtilisateurs:14]EmailASA:12=$EmailASA)
			If (Records in selection:C76([DiaUtilisateurs:14])=0)
				CREATE RECORD:C68([DiaUtilisateurs:14])
				[DiaUtilisateurs:14]EmailASA:12:=$EmailASA
			End if 
			[DiaUtilisateurs:14]AdresseUtilisateur:3:=Replace string:C233($AdresseUtilisateur;"£";<>ZCR)
			[DiaUtilisateurs:14]Caduc:13:=$CaducB
			[DiaUtilisateurs:14]CodeUtilisateur:11:=$CodeUtilisateur
			[DiaUtilisateurs:14]DateEnregistrement:7:=$DateEnregistrementD
			[DiaUtilisateurs:14]EmailASA:12:=$EmailASA
			[DiaUtilisateurs:14]EMailUtilisateur:6:=$EMailUtilisateurA
			[DiaUtilisateurs:14]MailEnvoiOK:9:=$MailEnvoiOKB
			[DiaUtilisateurs:14]NbreLicence:5:=$NbreLicenceN
			[DiaUtilisateurs:14]NbreUtilisation:4:=$NbUtilisationN
			[DiaUtilisateurs:14]NomUtilisateur:2:=$NomUtilisateur
			[DiaUtilisateurs:14]TexteEnregistrement:8:=Replace string:C233($TexteEnregistrement;"£";<>ZCR)
			[DiaUtilisateurs:14]TypeVersion:10:=$TypeVersion
			SAVE RECORD:C53([DiaUtilisateurs:14])
			RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
		Until ($Ligne="")
		ZAmnistiePartielle (->[DiaUtilisateurs:14])
	End if 
	CLOSE DOCUMENT:C267($Doc)
End if 
