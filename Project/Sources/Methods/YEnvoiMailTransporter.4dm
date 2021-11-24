//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Méthode : EnvoiMailTransporter
// Description
// Méthode qui envoie les mails
//   avec SMTP transporteur
// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 30/04/20, 05:18:27
// Paramètre : $1=objet de description contextuelle du mail
//   $Objet.to = adresse du (ou des) destinataire(s) * 
//   $Objet.subject = sujet du mail (texte)
//   $Objet.textBody = texte brut à envoyer
//   $Objet.htmlBody = html à envoyer
//               * (peut être une liste séparée par une virgule)

C_OBJECT:C1216($1; $transporter; $email; $status)
$email:=$1
$server:=New object:C1471
$server.host:="smtp.orange.fr"
$server.port:=465
$server.user:="asadiaweb"
$server.password:="1Asa2Raema"
$transporter:=SMTP New transporter:C1608($server)  //  Création du transporteur
$status:=$transporter.send($email)  // Envoi du message
$0:=$status