C_OBJECT:C1216($status; $email)

If (TbParticipantA=0)
	ALERT:C41("Merci de désigner quel laboratoire...")
Else 
	//$NumRaemaA:=Chaîne(TbComSaisie{TbComSaisie})
	$NumRaemaA:=TbParticipantA{TbParticipantA}
	$L:=Find in array:C230(<>TbPerNumLaboRAEMA; Num:C11($NumRaemaA))
	$CodeLabo:=<>TBPERIDENTIFICATEUR{$L}
	//ALLER À ENREGISTREMENT([WebConnexions];TbNumEnrComSaisie{TbComSaisie})
	QUERY:C277([WebConnexions:13]; [WebConnexions:13]Campagne:5=VarNumRaema; *)
	QUERY:C277([WebConnexions:13];  & [WebConnexions:13]CodeConnexion:4=$CodeLabo; *)
	QUERY:C277([WebConnexions:13];  & [WebConnexions:13]BoolEnvoi:8=True:C214)
	SELECTION TO ARRAY:C260([WebConnexions:13]TexteMail:6; $TbTexteMail; [WebConnexions:13]NumEnvoi:9; $TbNumEnvoi; [WebConnexions:13]DateConnexion:2; $TbDate; [WebConnexions:13]HeureConnexion:3; $TbHeure)
	SORT ARRAY:C229($TbNumEnvoi; $TbTexteMail; $TbDate; $TbHeure; <)
	//CHERCHER([WebConnexions];[WebConnexions]Commentaire#"")
	If (Size of array:C274($TbTexteMail)>0)
		//SÉLECTION VERS TABLEAU([WebConnexions]CodeConnexion;$TbCodePersonne\
									;[WebConnexions]TexteMail;$TbSaisie)
		//$L2:=Chercher dans tableau($TbCodePersonne;$CodeLabo)
		//$Saisie:=$TbSaisie{$L2}
		$message:="Bonjour,"+<>ZCR2+"Vous avez souhaitez recevoir la saisie du laboratoire "+$NumRaemaA
		$message:=$message+" pour la campagne n°"+VARNUMRAEMA+" envoyée par le laboratoire le "+String:C10($TbDate{1})+" à "+String:C10($TbHeure{1})+" :"+<>ZCR2+$TbTexteMail{1}+<>ZCR
		$message:=$message+<>ZCR2+"Bien cordialement"+<>ZCR+"--"+<>ZCR+"Le serveur de l'ASA"
		
		$Sujet:="Saisie du RAEMA n°"+VARNUMRAEMA+" par le laboratoire "+$NumRaemaA
		$email:=New object:C1471
		$transporter:=ASAPCreationtransporter
		$email.from:="asa-spv@wanadoo.fr"
		$email.subject:=$Sujet
		$email.to:="asa-spv@wanadoo.fr"
		//$email.to:="riouall.eloise@orange.fr"
		$email.textBody:=$message
		$status:=$transporter.send($email)  // Envoi du message
		MailOK:=($status.success)
		//ChercheDonneesCourielSortant 
		//$err:=SMTP_Charset (1;1)
		//$err:=SMTP_QuickSend (VarServeurSMTP;VarExpéditeur;VarExpéditeur;$Sujet;$message)
		//")"
		If (MailOK)
			ALERT:C41("mail envoyé")
		Else 
			ALERT:C41("mail NON envoyé")
		End if 
	Else 
		ALERT:C41("Le laboratoire sélectionné ne semble pas avoir encore saisie ses résultats")
	End if 
End if 