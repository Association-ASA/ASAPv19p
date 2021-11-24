  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 19/07/17, 15:32:12
  // ----------------------------------------------------
  // Méthode : DlgSuiviReponse.BossEnvoiFichier
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------
C_OBJECT:C1216($status)

$CD:=Get 4D folder:C485(Dossier base:K5:14)+"fichierraema.txt"

If (Test path name:C476($CD)=Est un document:K24:1)
	ARRAY TEXT:C222(TbMailCopie;1)
	TbMailCopie{1}:="cegeheme@wanadoo.fr"
	$Objet:="Fichier de statistique de la campagne RAEMA"
	$Corps:="Bonjour,"+<>ZCR2+"Après vérification de données, veuillez trouver en PJ le fichier validé pour l'étude statistique."
	$Corps:=$Corps+<>ZCR+"--"+<>ZCR+"Le serveur de l'ASA"
	  //$OK:=ASAPEnvoiMailDiscretBrut (VarServeurSMTP;VarExpéditeur;$Corps;"asa-spv@wanadoo.fr";->TbMailCopie;$Objet;$CD)
	$email:=New object:C1471
	$transporter:=ASAPCreationtransporter 
	$email.from:="asa-spv@wanadoo.fr"
	$email.subject:=$Objet
	$email.to:="asa-spv@wanadoo.fr,riouall.eloise@orange.fr"
	  //$email.to:="riouall.eloise@orange.fr"
	$email.textBody:=$Corps
	$email.attachments:=New collection:C1472(MAIL New attachment:C1644($CD))
	$status:=$transporter.send($email)  // Envoi du message
	$OK:=($status.success)
	
End if 
OBJECT SET VISIBLE:C603(BouEnvoiFichier;False:C215)
