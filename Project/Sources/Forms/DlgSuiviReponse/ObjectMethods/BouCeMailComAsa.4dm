  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 17/11/16, 14:51:03
  // ----------------------------------------------------
  // Méthode : DlgSuiviReponse.BouCeMailComAsa
  // Description
  // Permet d'envoyer le mail de communication lors de la campagne
  //
  // ----------------------------------------------------
C_OBJECT:C1216($status)
C_BOOLEAN:C305($OK)

If (TbComSaisie=0)
	ALERT:C41("Merci de désigner quel mail...")
Else 
	$NumRaemaA:=String:C10(TbComSaisie{TbComSaisie})
	$L:=Find in array:C230(<>TbPerNumLaboRAEMAA;$NumRaemaA)
	$Nom:=<>TbPerNomLong{$L}+" ("+<>TbPerAdrLivCP{$L}+"-"+<>TbPerAdrLivVille{$L}+")"
	$Mail:=<>TbPAEmailRAEMA{$L}
	$message:="Bonjour,"+<>ZCR2+"Le commentaire suivant a été adressé lors de la campagne "+VarNumRaema
	$message:=$message+" par le laboratoire n°"+$NumRaemaA+" "+$nom+" (mail : "+$mail+" ) :"+<>ZCR2+TbComCorps{TbComSaisie}+<>ZCR
	$message:=$message+<>ZCR2+"Bien cordialement"+<>ZCR+"--"+<>ZCR+"Le serveur de l'ASA"
	
	$Sujet:="Commentaires du RAEMA n°"+VARNUMRAEMA+" par le laboratoire "+$NumRaemaA
	
	$email:=New object:C1471
	$transporter:=ASAPCreationtransporter 
	$email.from:="asa-spv@wanadoo.fr"
	$email.subject:=$Sujet
	$email.to:="asa-spv@wanadoo.fr"
	$email.textBody:=$message
	  //$email.attachments:=Créer collection(MAIL Créer pièce jointe($CD))
	$status:=$transporter.send($email)  // Envoi du message
	$OK:=($status.success)
	
	  //ChercheDonneesCourielSortant 
	  //$err:=SMTP_Charset (1;1)
	  //$err:=SMTP_QuickSend (VarServeurSMTP;VarExpéditeur;VarExpéditeur;$Sujet;$message)
	If ($OK)
		ALERT:C41("mail envoyé")
	Else 
		ALERT:C41("mail NON envoyé")
	End if 
End if 
