//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 05/08/18, 15:03:54
// ----------------------------------------------------
// Paramètres
// ----------------------------------------------------
// Méthode : ResP3EnvoiMailAsa <= ResP3TraitePage3 <= ResP3MF de la page 3 
// ou  ResP3EnvoiMailAsa <= ResP3bEnvoiResultats <= ResP3MF de la page 3 
// Description
// 

C_BOOLEAN:C305(MailOK)
C_OBJECT:C1216($status; $status1; $email1; $email)
C_LONGINT:C283($Err; $Pos; $NumDerEnvoi)

// écrivons la PJ

//$Err:=SMTP_SetPrefs (1;1;-1)
//$Err:=SMTP_Charset (1;1)
$Campagne:=[WebConnexions:13]Campagne:5
$UUIDPerso:=[WebConnexions:13]CodeConnexion:4
$NumEnr:=Record number:C243([WebConnexions:13])
QUERY:C277([WebConnexions:13]; [WebConnexions:13]Campagne:5=$Campagne; *)
QUERY:C277([WebConnexions:13];  & [Personnes:12]Identificateur:4=$UUIDPerso; *)
QUERY:C277([WebConnexions:13];  & [WebConnexions:13]BoolEnvoi:8=True:C214)
$combien:=Records in selection:C76([WebConnexions:13])
$NumDerEnvoi:=Max:C3([WebConnexions:13]NumEnvoi:9)
GOTO RECORD:C242([WebConnexions:13]; $NumEnr)

If ([WebConnexions:13]Commentaire:14#"")
	$L:=Find in array:C230(<>TbPerNumLaboRAEMAA; NumLaboActuelA)
	If ($L>0)
		$Nom:=<>TbPerNomLong{$L}+" ("+<>TbPerAdrLivCP{$L}+"-"+<>TbPerAdrLivVille{$L}+")"
		$Mail:=<>TbPAEmailRAEMA{$L}
	Else 
		$Nom:=""
		$Mail:=""
	End if 
	$Commentaire:="Bonjour,"+<>ZCR2+"Le commentaire suivant a été adressé lors de la campagne "+$Campagne
	$Commentaire:=$Commentaire+" par le laboratoire n°"+NumLaboActuelA+" "+$nom+" (mail : "+$mail+" ) :"+<>ZCR2+[WebConnexions:13]Commentaire:14+<>ZCR
	$Commentaire:=$Commentaire+<>ZCR2+"Bien cordialement"+<>ZCR+"--"+<>ZCR+"Le serveur de l'ASA"
	//$Commentaire:="Commentaire laissé par le laboratoire "+NumLaboActuelA+" :"+<>ZCR+[WebConnexions]Commentaire
	$Sujet1:="Commentaire laissé par le laboratoire "+NumLaboActuelA+" à la campagne "+$Campagne
	$email1:=New object:C1471
	$transporter1:=ASAPCreationtransporter
	$email1.from:="asa-spv@wanadoo.fr"
	$email1.subject:=$Sujet1
	$email1.to:="riouall.eloise@orange.fr,asa.eloise@gmail.com,asa-spv@wanadoo.fr"
	$email1.textBody:=$Commentaire
	$status1:=$transporter1.send($email1)  // Envoi du message
	MailOK1:=($status1.success)
End if 


$Envoi:=NumLaboActuelA+"_"+String:C10($NumDerEnvoi)
$TexteMail:=[WebConnexions:13]TexteMail:6
$PJMail:=[WebConnexions:13]TextePJ:7
$Pos:=Position:C15(<>ZTab; $PJMail)
$PJMail:=Substring:C12($PJMail; $Pos)
$RangEnvoi:=[WebConnexions:13]NumEnvoi:9
$NomCourtFichier:="RAEMA"+NumCampagneCourante+"_Labo"+NumLaboActuelA+"_"+String:C10($RangEnvoi)+".TXT"
$Message:=Num:C11([WebConnexions:13]Commentaire:14#"")*(<>ZCR+"Commentaire laissé par le laboratoire : "+<>ZCR+[WebConnexions:13]Commentaire:14+<>ZCR2)
$AnalysesFichiers:=ResP3AnalyseFichiersPrecedents
$RangEnvoiA:=String:C10([WebConnexions:13]NumEnvoi:9)
$CD:=<>CDDossierEmailsContraries+$NomCourtFichier
If (Test path name:C476($CD)=Est un document:K24:1)  // Si le document existe
	DELETE DOCUMENT:C159($CD)  //On s'en débarasse
End if 
$Doc:=Create document:C266($CD)
$Envoi:=$Envoi+$PJMail
SEND PACKET:C103($Doc; $Envoi)
CLOSE DOCUMENT:C267($Doc)
// envoi du mail
$CorpsMessage:=RaemaTraducUtiliseTableau(66)+NumLaboActuelA
$CorpsMessage:=$CorpsMessage+<>ZCR+$TexteMail+<>ZCR+$Message+$AnalysesFichiers
$Pb:=""  // détection d'éventuels Pb mis en place pour le raema 41
$TestKO:=ResP3TestePJ($PJMail)

If ($TestKO)  // test de concordance description - fichier
	$Pb:="Pb sur "
End if 

$Sujet:=$Pb+"Saisie du RAEMA "+NumCampagneCourante+" sur internet pour le labo numéro "+NumLaboActuelA
Destinataire:=""  // nom du destinataire principal renseigné dans WMg_Envoi_ComplexeMassif
//ASAPChercheDonneesCourriel 
//  //ZBlobVersVariable (->[XData]XBlob;->TbMailCopie;->VarSignatureCourriel;->TbMailRes;->TbMailAR;->TbMailMAJC;->TbMailEnvoi;->TbMailMAJL)
//  //TABLEAU TEXTE(TbMailRes;0)
//  //AJOUTER À TABLEAU(TbMailRes;"cegeheme@wanadoo.fr")
//  //AJOUTER A TABLEAU(TbMailRes;"saisie.raema@orange.fr")
//  //AJOUTER A TABLEAU(TbMailRes;"jcaugustin@vet-alfort.fr")
//  //AJOUTER A TABLEAU(TbMailRes;"asa-spv@wanadoo.fr")
//  // Le mdp caché est-il correct ?
//  //Si (ResP3ChasseLaboFantomes )  // Le mdp caché est correct
//MailOK:=EnvoiMailDiscretVintage ("smtp.orange.fr";"asa-spv@wanadoo.fr";$TexteMail;"asa.eloise@gmail.com";->TbMailRes;$Sujet;$CD)
//MailOK:=WMg_Envoi_ComplexeMassif

$email:=New object:C1471
$transporter:=ASAPCreationtransporter
$email.from:="asa-spv@wanadoo.fr"
$email.subject:=$Sujet
$email.to:="riouall.eloise@orange.fr,asa.eloise@gmail.com,cegeheme@wanadoo.fr,saisie.raema@orange.fr,saisie.raema@wanadoo.fr"
$email.textBody:=$CorpsMessage
$email.attachments:=New collection:C1472(MAIL New attachment:C1644($CD))
$status:=$transporter.send($email)  // Envoi du message
MailOK:=($status.success)

If (MailOK)
	DELETE DOCUMENT:C159($CD)  //On s'en débarasse
Else 
	//WEB ENVOYER FICHIER(TraducUtiliseTableau (80))
	$CD2:=<>CDDossierEmailsContraries+"RAEMA"+NumCampagneCourante+" labo "+NumLaboActuelA+"_"+$RangEnvoiA+"(descriptif).TXT"
	If (Test path name:C476($CD2)=Est un document:K24:1)  //Si le document existe
		DELETE DOCUMENT:C159($CD2)  //On s'en débarasse
	End if 
	$Doc2:=Create document:C266($CD2)
	SEND PACKET:C103($Doc2; $TexteMail)
	CLOSE DOCUMENT:C267($Doc2)
End if 

ResP3HtmlPageAR
ResP3HtmlListeLaboInternet
ZAmnistieInternationale
//Fin de si 