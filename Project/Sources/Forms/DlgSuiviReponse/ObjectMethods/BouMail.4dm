  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 17/11/16, 14:51:03
  // ----------------------------------------------------
  // Méthode : DlgSuiviReponse.BouMail
  // Description
  // Permet d'envoyer les mails de relance pour les participants 
  // du loto n'ayant pas encore envoyé leurs résultats et ne faisant
  // pas parti des cas particuliers
  //
  // ----------------------------------------------------

  // $test:=Vrai
  // Participants de la campagne qui n'ont pas répondu
  //UTILISER ENSEMBLE("Absence")
  //  // Enlevons les cas particuliers
  //CRÉER SELECTION SUR TABLEAU([CampagneParticipations];TbNumEnrParticuliers)
  //NOMMER ENSEMBLE("$Particuliers")
  //DIFFÉRENCE("Absence";"$Particuliers";"$Envoi")
  //UTILISER ENSEMBLE("$Envoi")
  //SÉLECTION VERS TABLEAU([CampagneParticipations]UUIDPersonne;$TbUUIDLabo)
C_OBJECT:C1216($status;$email)
C_BOOLEAN:C305($OK)

$TT:=Size of array:C274(TbAbsent)
QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=VarNumRaema)
$message:="Madame, Monsieur, bonjour,"+<>ZCR2+"Nous vous rappelons que la date limite de rendu des résultats est fixée au "+String:C10([RAEMACampagnes:20]DateLimiteReponse:4)+"."
$message:=$message+<>ZCR+"Nous vous remercions de bien vouloir vous loguer sur le site de l'ASA (https://www.association.asa-spv.fr) afin de nous envoyer votre saisie."
  //$message:=$message+<>ZCR2+"Passé ce délai, nous ne serons pas en mesure de tenir compte de vos résultats."
$message:=$message+<>ZCR2+"Restant à votre disposition."+<>ZCR2+"Bien cordialement"+<>ZCR+"--"+<>ZCR+"L'équipe du RAEMA"
$MessASA:="Le mail ci-dessous a été envoyé aux destinataires suivant : "+<>ZCR+$message+<>ZCR2
$Objet:="Rappel date limite de saisie des résultats RAEMA"
$MessBienEnvoyé:="Le mail A BIEN été envoyé aux labos :"+<>ZCR
$MessPasEnvoyé:="Le mail N'A PAS été envoyé aux labos :"+<>ZCR
For ($Salé;1;$TT)
	$L3:=Find in array:C230(<>TbLotoUUIDParticipation;TbAbsent{$Salé})
	$UUIDLabo:=<>TbLotoUUIDLabo{$L3}
	$NumLabo:=ASAPTrouveNumeroLaboParUUID ($UUIDLabo)
	
	$L:=Find in array:C230(TbCasParticuliersA;$NumLabo)
	If ($L<0)
		
		$L2:=Find in array:C230(<>TbPerUUID;$UUIDLabo)
		If ($L2>0)
			$Destinataire:=<>TbPAEmailRAEMA{$L2}
			$email:=New object:C1471
			$transporter:=ASAPCreationtransporter 
			$email.from:="asa-spv@wanadoo.fr"
			$email.subject:=$Objet
			$email.to:=$Destinataire
			$email.textBody:=$message
			$status:=$transporter.send($email)  // Envoi du message
			$OK:=($status.success)
			If ($OK)
				$MessBienEnvoyé:=$MessBienEnvoyé+$Destinataire+<>ZCR
			Else 
				$MessPasEnvoyé:=$MessPasEnvoyé+$Destinataire+<>ZCR
			End if 
		Else   // On a pas trouvé le labo donc pas d'envoi de mail
			$Destinataire:="Erreur avec le laboratoire "+TbAbsent{$Salé}
			$MessPasEnvoyé:=$MessPasEnvoyé+$Destinataire+<>ZCR
		End if 
	End if 
End for 
$MessASA:=$MessASA+$MessBienEnvoyé+<>ZCR+$MessPasEnvoyé
$email:=New object:C1471
$transporter:=ASAPCreationtransporter 
$email.from:="asa-spv@wanadoo.fr"
$email.subject:="Récapitulatif envoi mail rappel date limite saisie"
$email.to:="asa-spv@wanadoo.fr,riouall.eloise@orange.fr"
$email.textBody:=$MessASA
$status:=$transporter.send($email)  // Envoi du message
$OK:=($status.success)
If ($OK)
	SET TEXT TO PASTEBOARD:C523($MessASA)
	ALERT:C41("Le mail récapilatif vient d'être envoyé à l'ASA et d'être copié dans votre press papier.")
Else 
	SET TEXT TO PASTEBOARD:C523($MessASA)
	ALERT:C41("Le mail récapilatif n'a pas pu être envoyé à l'ASA mais vient d'être copié dans votre press papier.")
End if 

  //$message:="Madame, Monsieur, bonjour,"+<>ZCR2+"Il vous reste "+DelaiReponseA+" jours pour répondre au questionnaire du RAEMA."
  //$message:=$message+<>ZCR+"Merci de bien vouloir vous loguer sur le site de l'ASA (https://www.association.asa-spv.fr) pour nous envoyer vos résultats."
  ////$message:=$message+<>ZCR2+"Passé ce délai, nous ne serons pas en mesure de tenir compte de vos résultats."
  //$message:=$message+<>ZCR2+"Comptant sur votre diligence."+<>ZCR2+"Bien cordialement"+<>ZCR+"--"+<>ZCR+"L'équipe du RAEMA"
  //$TT:=Taille tableau($TbUUIDLabo)
  //$err:=SMTP_Charset (1;1)
  //Boucle ($salé;1;$TT)
  //Si ($test)
  //$Mail:="asa-spv@wanadoo.fr"
  //Sinon 
  //$L:=Chercher dans tableau(<>TbUUID;$TbUUIDLabo{$salé})
  //$Mail:=<>TbPAEmailRAEMA{$L}
  //Fin de si 
  //$err:=SMTP_QuickSend ("SMTP.orange.fr";"asa-spv@wanadoo.fr";$Mail;"Saisie des résultats du RAEMA n°"+VARNUMRAEMA;$message)
  //Fin de boucle 