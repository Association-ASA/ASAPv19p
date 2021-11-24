//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 12/04/21, 16:08:15
  // ----------------------------------------------------
  // Méthode : ASAPEnvoiFactureLabo
  // Description
  // Méthode qui envoi le lien de la facture au labo 
  // séléctionnés
  // ----------------------------------------------------

SELECTION TO ARRAY:C260([Factures:15]NumFacture:3;$TbNumFacture;[Factures:15]UUIDPersonne:2;$TbUUIDPersonne)
$TT:=Size of array:C274($TbUUIDPersonne)
For ($Salé;1;$TT)
	$Sujet:="Votre facture RAEMA est à présent disponible"
	$L:=Find in array:C230(<>TBPERUUID;$TbUUIDPersonne{$Salé}
	$NumAdhérent:=String:C10(<>TbPerNumPersonne{$L})
	$NumFacture_:=Replace string:C233($TbNumFacture{$Salé};"/";"_")
	$LienFacture:="https://association.asa-spv.fr/PDF/Factures/"+$NumAdhérent"/"+$NumFacture_+".pdf"
	$Message:="Chers participant au RAEMA, bonjour,"+<>ZCR2
	$Message:=$Message+"Vous avez, à présent, accès à votre facture RAEMA Poudre 2021, à l’aide du lien suivant:"+<>ZCR+$LienFacture+<>ZCR
	$Message:=$Message+"Nous vous informons que votre facture est également disponible dans votre « Espace participant » - rubrique « Documents »."+<>ZCR
	$Message:=$Message+"Si, pour votre gestion interne, vous avez besoin d’un envoi par courrier postal, n’hésitez pas à nous en informer."+<>ZCR
	$Message:=$Message+"Nous vous rappelons que le règlement de votre facture peut s’effectuer par virement bancaire."
	$Message:=$Message+"Les coordonnées bancaires de l’ASA figurent dans votre « Espace participant – Documents - Télécharger vos factures - Télécharger le relevé d'identité bancaire de l'ASA », "
	$Message:=$Message+"ainsi qu'en haut à gauche de votre facture."+<>ZCR
	$Message:=$Message+"Vous avez également la possibilité d’adresser un chèque libellé à l’ordre l’ASA, à l’adresse suivante :"+<>ZCR
	$Message:=$Message+"ASA"+<>ZCR+"7 avenue du général de Gaulle"+<>ZCR+"ENVA – Bâtiment Jean Girard"+<>ZCR"94700 Maisons-Alfort"+<>ZCR
	$Message:=$Message+"Quel que soit le mode règlement, nous vous remercions de bien faire référence."+<>ZCR
	$Message:=$Message+"Nous restons à votre disposition pour tout complément d’information."+<>ZCR
	$Message:=$Message+"Cordialement,"+<>ZCR2
	$Message:=$Message+"L'équipe de l'ASA"
	
	$email:=New object:C1471
	$transporter:=ASAPCreationtransporter 
	$email.from:="asa-spv@wanadoo.fr"
	$email.subject:=$Sujet
	$email.to:="riouall.eloise@orange.fr"
	$email.textBody:=$Message
	$status:=$transporter.send($email)  // Envoi du message
	MailOK:=($status.success)
End for 

