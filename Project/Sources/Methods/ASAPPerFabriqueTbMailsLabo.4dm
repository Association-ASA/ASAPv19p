//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 11/07/18, 19:25:03
  // ----------------------------------------------------
  // Méthode : GAFabriqueTableauMailsLabo
  // Paramètres : $1= nom de la propriété  
  // $2 à $4 booléens d'appartenance à Info, Rapport Compta 
  // Description
  // Permet de construire les tableaux des mails des laboratoires
  // ----------------------------------------------------
$Propriété:=$1
$InfoOK:=$2
$RapportOK:=$3
$ComptaOK:=$4
$LivraisonOK:=$5
$Mail:=OB Get:C1224([Personnes:12]Arguments:7;$Propriété;Est un texte:K8:3)
$Pos:=Position:C15(",";$Mail)

While ($Pos>0)
	$Candidat:=Substring:C12($Mail;1;($Pos-1))
	If (Length:C16($Candidat)>0)  // un test de validité de mail serait meilleur
		$Pos3:=Position:C15("@";$Candidat)
		$CandidatSansArobase:=Substring:C12($Candidat;1;($pos3-1))+Substring:C12($Candidat;($pos3+1))
		$L:=Find in array:C230(TbMailsSansArobase;$CandidatSansArobase)
		If ($L<0)
			APPEND TO ARRAY:C911(TbMails;$Candidat)
			APPEND TO ARRAY:C911(TbMailInfo;$InfoOK)
			APPEND TO ARRAY:C911(TbMailRapport;$RapportOK)
			APPEND TO ARRAY:C911(TbMailCompta;$ComptaOK)
			APPEND TO ARRAY:C911(TbMailLivraison;$LivraisonOK)
			APPEND TO ARRAY:C911(TbMailsSansArobase;$CandidatSansArobase)
		Else 
			If (TbMailInfo{$L}=False:C215) & ($InfoOK)
				TbMailInfo{$L}:=True:C214
			End if 
			If (TbMailRapport{$L}=False:C215) & ($RapportOK)
				TbMailRapport{$L}:=True:C214
			End if 
			If (TbMailCompta{$L}=False:C215) & ($ComptaOK)
				TbMailCompta{$L}:=True:C214
			End if 
			If (TbMailLivraison{$L}=False:C215) & ($LivraisonOK)
				TbMailLivraison{$L}:=True:C214
			End if 
		End if 
	End if 
	$Mail:=Substring:C12($Mail;($Pos+1))
	$Pos:=Position:C15(",";$Mail)
End while 
If (Length:C16($Mail)>0)  // un test de validité de mail serait meilleur
	$Pos4:=Position:C15("@";$Mail)
	$MailSansArobase:=Substring:C12($Mail;1;($pos4-1))+Substring:C12($Mail;($pos4+1))
	$L:=Find in array:C230(TbMailsSansArobase;$MailSansArobase)
	  //$L:=Chercher dans tableau(TbMails;$Mail)
	If ($L<0)
		APPEND TO ARRAY:C911(TbMails;$Mail)
		APPEND TO ARRAY:C911(TbMailInfo;$InfoOK)
		APPEND TO ARRAY:C911(TbMailRapport;$RapportOK)
		APPEND TO ARRAY:C911(TbMailCompta;$ComptaOK)
		APPEND TO ARRAY:C911(TbMailLivraison;$LivraisonOK)
		APPEND TO ARRAY:C911(TbMailsSansArobase;$MailSansArobase)
	Else 
		If (TbMailInfo{$L}=False:C215) & ($InfoOK)
			TbMailInfo{$L}:=True:C214
		End if 
		If (TbMailRapport{$L}=False:C215) & ($RapportOK)
			TbMailRapport{$L}:=True:C214
		End if 
		If (TbMailCompta{$L}=False:C215) & ($ComptaOK)
			TbMailCompta{$L}:=True:C214
		End if 
		If (TbMailLivraison{$L}=False:C215) & ($LivraisonOK)
			TbMailLivraison{$L}:=True:C214
		End if 
	End if 
End if 
