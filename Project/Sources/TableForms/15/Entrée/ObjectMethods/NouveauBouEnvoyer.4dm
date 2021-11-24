C_OBJECT:C1216($status;$email)

$NumFacture:=[Factures:15]NumFacture:3
$Objet:="Confirmation de paiement de la facture n°"+$NumFacture
$Destinataire:=OB Get:C1224([Personnes:12]Arguments:7;"EmailCompta";Est un texte:K8:3)
If ($Destinataire="")
	$Destinataire:=OB Get:C1224([Personnes:12]Arguments:7;"EMail";Est un texte:K8:3)
End if 

Case of 
	: ([Personnes:12]TypePersonne:5="Laboratoire")
		$NomLabo:="Cher laboratoire "+[Personnes:12]NomLong:2
		
		
	: ([Personnes:12]TypePersonne:5="individu")
		$Prénom:=OB Get:C1224([Personnes:12]Arguments:7;"Prénom")
		$NomLabo:=$Prénom+" "+[Personnes:12]NomLong:2
		
		  // Prévoir à terme les partenaires et les prospects
End case 
$Message:=$NomLabo+","+<>ZCR+<>ZCR+"Votre paiement concernant la facture "+$NumFacture+" a bien été pris en compte, nous vous en remercions."
$Message:=$Message+<>ZCR+"Restant à votre disposition."+<>ZCR+<>ZCR+"Cordialement,"+<>ZCR+<>ZCR+"L'équipe de l'ASA"

$email:=New object:C1471
$transporter:=ASAPCreationtransporter 
$email.from:="asa-spv@wanadoo.fr"
$email.subject:=$Objet
$email.to:="asa-spv@wanadoo.fr,"+$Destinataire
$email.textBody:=$Message
$status:=$transporter.send($email)  // Envoi du message
MailOK:=($status.success)

If (MailOK)
	ALERT:C41("Le mail a bien été envoyé! L'ASA est en copie de ce mail")
Else 
	ALERT:C41("Le mail N'A PAS été envoyé!")
End if 
