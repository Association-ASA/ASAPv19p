//%attributes = {"lang":"fr"}
//  ResP4MF
// permet d'envoyer un mail d'accusé de réception
// appelée par la page 4 si le labo veut un AR

C_TEXT:C284($ResumeCampagne)
C_BOOLEAN:C305($OK)
C_OBJECT:C1216($status)

<>ZCRWeb:=<>ZCR
ARRAY TEXT:C222(TbNomsP5; 0)
ARRAY TEXT:C222(TbValeursP5; 0)
WEB GET VARIABLES:C683(TbNomsP5; TbValeursP5)
$ValeurAdresseCourrielA:=WebTrouveValeurParNom("mail1"; ->TbNomsP5; ->TbValeursP5)
$ValeurAdresseCourrielB:=WebTrouveValeurParNom("mail12"; ->TbNomsP5; ->TbValeursP5)
UUIDParticipation:=WebTrouveValeurParNom("hiddenField"; ->TbNomsP5; ->TbValeursP5)
QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]UUID:1=UUIDParticipation)
$L:=Find in array:C230(<>TbLotoUUIDParticipation; UUIDParticipation)
If ($L>0)
	$UUIDLabo:=<>TbLotoUUIDLabo{$L}
Else 
	$UUIDLabo:=[CampagneParticipations:17]UUIDPersonne:2
End if 
$LigneTbGnxPart:=Find in array:C230(<>TbLotoUUIDParticipation; UUIDParticipation)
If (<>TbLotoNumLaboRapportCampagne{$LigneTbGnxPart}#"")
	$pos:=Position:C15("_"; <>TbLotoNumLaboRapportCampagne{$LigneTbGnxPart})
	NumLaboActuelA:=Substring:C12(<>TbLotoNumLaboRapportCampagne{$LigneTbGnxPart}; 1; ($pos-1))
Else 
	NumLaboActuelA:=String:C10(WebTrouveValeurParNom(UUIDParticipation; -><>TbLotoUUIDParticipation; -><>TbLotoNumLaboRAEMA))
End if 

//NumLaboActuelA:=ASAPTrouveNumeroLaboParUUID ($UUIDLabo)
//NumLaboActuelA:=WebTrouveValeurParNom (MotDePasseActuel;-><>TbPerIdentificateur;-><>TbPerNumLaboRAEMAA)
LangueCourante:=WebTrouveValeurParNom("langage"; ->TbNomsP5; ->TbValeursP5)

WebLireTableauxAnterieurs
WebActualiseConnexionSaisie(NumLaboActuelA; 5; $ValeurAdresseCourrielA)
AlerteMail:=""
If ($ValeurAdresseCourrielA#$ValeurAdresseCourrielB)
	//AlerteMail:=TraducUtiliseTableau (64)+<>ZCR
	//AlerteMail:=AlerteMail+TraducUtiliseTableau (65)
	//ALERTE(AlerteMail)
	MotifErreur1:=RaemaTraducUtiliseTableau(64)+<>ZCR
	MotifErreur2:=RaemaTraducUtiliseTableau(65)+<>ZCR
	MotifErreur3:=""
	RapAffichePb("Erreur de mail"; "VERIFICATION DES SAISIES"; MotifErreur1; MotifErreur2; MotifErreur3)
Else 
	If (YTesteValiditeCourriel($ValeurAdresseCourrielA))
		If (Find in array:C230(TbNomsP5; "checkbox")>0)  // il a coché la case pour qu'on se rappelle son mail
			READ WRITE:C146([Personnes:12])
			QUERY:C277([Personnes:12]; [Personnes:12]Identificateur:4=MotDePasseActuel)
			OB SET:C1220([Personnes:12]Arguments:7; "EmailRAEMA"; $ValeurAdresseCourrielA)
			SAVE RECORD:C53([Personnes:12])
			ZAmnistiePartielle(->[Personnes:12])
		End if 
	End if 
	
	$NumRaema:=<>NumCampagneEnCoursSaisie
	$Objet:=RaemaTraducUtiliseTableau(57)+$NumRaema
	
	$TexteMail:=ZTableauVersTexte(->TbTexteResume)
	
	$Texte:=RaemaTraducUtiliseTableau(58)+<>ZCR+RaemaTraducUtiliseTableau(59)+$NumRaema
	
	$Texte:=$Texte+<>ZCR+RaemaTraducUtiliseTableau(60)+<>ZCR+RaemaTraducUtiliseTableau(61)
	$Texte:=$Texte+<>ZCR+RaemaTraducUtiliseTableau(62)
	$Texte:=$Texte+<>ZCR+$TexteMail
	$Texte:=$Texte+<>ZCR+<>ZCR+RaemaTraducUtiliseTableau(63)
	If (LangueCourante="F")
		$PS:="PS : Veuillez trouver en pièce-jointe le fichier des résultats que vous pouvez ouvrir "
		$PS:=$PS+"avec un tableur si vous le désirez (codage iso-latin 1)"
	Else 
		$PS:="Please find enclosed the results file (iso-latin 1 encoding). "
		$PS:=$PS+"You can, if you would like,  open it by using spreadsheet software (e.g. Excel)"
	End if 
	$Texte:=$Texte+<>ZCR+<>ZCR+$PS+<>ZCR+<>ZCR
	
	$CD:=Get 4D folder:C485(Dossier 4D actif:K5:10)+"Resume"+"_"+$NumRaema+"_"+NumLaboActuelA+".txt"
	If (Test path name:C476($CD)=Est un document:K24:1)
		DELETE DOCUMENT:C159($CD)
	End if 
	USE CHARACTER SET:C205("ISO-8859-1"; 0)
	$Doc:=Create document:C266($CD)
	//$UUID:=WebTrouveValeurParNom (MotDePasseActuel;-><>TbPerIdentificateur;-><>TbPerUUID)
	QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]UUID:1=UUIDParticipation)
	$ResumeCampagne:=OB Get:C1224([CampagneParticipations:17]Arguments:5; "RésuméRésultats"; Est un texte:K8:3)
	SEND PACKET:C103($Doc; $ResumeCampagne)
	CLOSE DOCUMENT:C267($Doc)
	USE CHARACTER SET:C205(*; 0)
	
	//ASAPChercheDonneesCouriel 
	//  // ZBlobVersVariable (->[XData]XBlob;->TbMailCopie;->VarSignatureCourriel;->TbMailRes;->TbMailAR;->TbMailMAJC;->TbMailEnvoi;->TbMailMAJL)
	
	//  //$OK:=EnvoiMailDiscret ([XData]XTexte;"asa-spv@wanadoo.fr";$Texte;$ValeurAdresseCourrielA;->TbMailAR;$Objet;$CD)
	//$OK:=EnvoiMailDiscretVintage ("smtp.orange.fr";"asa-spv@wanadoo.fr";$Texte;"asa.eloise@gmail.com";->TbMailAR;$Objet;$CD)
	
	$email:=New object:C1471
	$transporter:=ASAPCreationtransporter
	$email.from:="asa-spv@wanadoo.fr"
	$email.subject:=$Objet
	$email.to:=$ValeurAdresseCourrielA+",cegeheme@wanadoo.fr,asa.eloise@gmail.com,riouall.eloise@orange.fr"
	$email.textBody:=$Texte
	$email.attachments:=New collection:C1472(MAIL New attachment:C1644($CD))
	$status:=$transporter.send($email)  // Envoi du message
	$OK:=($status.success)
	
	//FIXER TEXTE DANS CONTENEUR($Texte)
	// ProcNom:=$ProcNom
	If ($OK)
		ResP4AROK
		WebHistoireConnexion(NumLaboActuelA; 4)
	Else 
		ResP4ARKO
	End if 
End if 
