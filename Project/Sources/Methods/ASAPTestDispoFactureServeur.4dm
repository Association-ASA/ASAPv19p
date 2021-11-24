//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : ASA
// Date et heure : 14/04/21, 13:40:16
// ----------------------------------------------------
// Méthode : ASAPTestDispoFactureServeur
// Description
// 
//
// Paramètres
// ----------------------------------------------------
ARRAY TEXT:C222($TbNumFacture; 0)
ARRAY TEXT:C222($TbUUIDPersonne; 0)
ZTexteVersTableau($1; ->$TbNumFacture)
ZTexteVersTableau($2; ->$TbUUIDPersonne)
$TT:=Size of array:C274($TbNumFacture)
$Message:=""
For ($Salé; 1; $TT)
	$L:=Find in array:C230(<>TBPERUUID; $TbUUIDPersonne{$Salé})
	If ($L<0)
		$Message:=$Message+"Le numéro de labo pour la facture "+$TbNumFacture{$Salé}+" n'a pas pu être déterminé et donc le test de disponibilité non effectué."+<>ZCR
	Else 
		$NumAdhérent:=<>TbPerNumPersonne{$L}
		$NumFacture_:=Replace string:C233($TbNumFacture{$Salé}; "/"; "_")
		$CDFac:=<>PermCheDosFac+String:C10($NumAdhérent)+Séparateur dossier:K24:12+$NumFacture_+".pdf"
		If (Test path name:C476($CDFac)#Est un document:K24:1)
			$NumLabo:=<>TbPerNumLaboRAEMA{$L}
			$Message:=$Message+"La facture "+$TbNumFacture{$Salé}+" n'apparait pas dans le dossier du labo "+String:C10($NumLabo)+"."+<>ZCR
		End if 
	End if 
End for 
If ($Message="")
	$Message:="Toutes les factures séléctionnées sont bien disponible sur le serveur."
End if 
$email:=New object:C1471
$transporter:=ASAPCreationtransporter
$email.from:="asa-spv@wanadoo.fr"
$email.subject:="Disponibilité des factures sur le serveur"
$email.to:="asa-spv@wanadoo.fr,riouall.eloise@orange.fr"
$email.textBody:=$Message
$status:=$transporter.send($email)  // Envoi du message
MailOK:=($status.success)
