//%attributes = {}
C_OBJECT:C1216($status;$email)

  //LECTURE ÉCRITURE([CampagneParticipations])
  //LECTURE ÉCRITURE([CampagneGelGermes])
  //CHERCHER([CampagneParticipations];[CampagneParticipations]NumCampagne=<>CampagneDevisRGMai;*)
  //CHERCHER([CampagneParticipations]; | [CampagneParticipations]NumCampagne=<>CampagneDevisRGDec;*)
  //CHERCHER([CampagneParticipations]; & [CampagneParticipations]UUIDPersonne=[Personnes]UUID)
  //SÉLECTION RETOUR([CampagneGelGermes]UUIDParticipation)  // sélection des [CampagneGelGermes]
  //SUPPRIMER SÉLECTION([CampagneGelGermes])
  //SUPPRIMER SÉLECTION([CampagneParticipations])
  //LECTURE SEULEMENT([CampagneParticipations])
  //LECTURE SEULEMENT([CampagneGelGermes])

MailDevis:=""
MailDevis:=MailDevis+"Cher laboratoire,"+<>ZCR2+"Nous accusons réception de votre bon de commande RAEMA Gel et vous en remercions :"+<>ZCR
$L:=Find in array:C230(<>TbCampagnesNumCampagne;<>CampagneDevisRGMai)

If (<>TbCampagnesDateEnvoiColis{$L}>Current date:C33)
	If (Size of array:C274(TbNomGermeMai)>0)
		ASAPDevisCreationCampagne (<>CampagneDevisRGMai)
	End if 
End if 
$L:=Find in array:C230(<>TbCampagnesNumCampagne;<>CampagneDevisRGDec)
If (<>TbCampagnesDateEnvoiColis{$L}>Current date:C33)
	If (Size of array:C274(TbNomGermeDec)>0)
		ASAPDevisCreationCampagne (<>CampagneDevisRGDec)
	End if 
End if 
MailDevis:=MailDevis+<>ZCR+"Nous vous précisons que votre inscription sera définitive sous réserve de l'acquittement des factures RAEMA Gel antérieures."+<>ZCR
MailDevis:=MailDevis+"Restant à votre disposition."+<>ZCR+"Cordialement,"+<>ZCR2+"L'équipe de l'ASA"

READ WRITE:C146([PersonnesDevis:30])
GOTO RECORD:C242([PersonnesDevis:30];Colonne2N{LigneCliqueDansBDDevis})
[PersonnesDevis:30]Valide:8:=True:C214
[PersonnesDevis:30]QuiValideQuand:10:=[PersonnesDevis:30]QuiValideQuand:10+"Le "+String:C10(Current date:C33)+" à "+String:C10(Current time:C178)+" le devis a été validé par "+<>ZQuiVaLa
SAVE RECORD:C53([PersonnesDevis:30])
  // GA15RaemaGelActualiseLoto(VarPermMilleRaemaGel)

  // Rendre caducs les devis du même laboratoire
  //$Pivot:=Date("15/12/"+Chaîne(Num(VarPermMilleRaemaGel)-1))
$UUID:=ASAPTrouveUUIDLaboParNumero (Colonne1EC{Colonne1EC})
QUERY:C277([PersonnesDevis:30];[PersonnesDevis:30]UUIDPersonne:6=$UUID;*)  // même labo
  // CHERCHER([XData];&[XData]XDate>$Pivot;*)
QUERY:C277([PersonnesDevis:30]; & [PersonnesDevis:30]Valide:8=False:C215;*)
QUERY:C277([PersonnesDevis:30]; & [PersonnesDevis:30]Caduc:7="")
APPLY TO SELECTION:C70([PersonnesDevis:30];[PersonnesDevis:30]Caduc:7:="Caduc par doublon")

QUERY:C277([Personnes:12];[Personnes:12]UUID:1=$UUID)
$AdEmail:=OB Get:C1224([Personnes:12]Arguments:7;"EMail";Est un texte:K8:3)
$AdEmails:=Request:C163("Le mail va être envoyé à "+$AdEmail+". Ajouter des destinataires ou laisser cette case vide. Séparer les adresses par une virgule. Si vous annulez, le texte sera copié dans le press papier.")
If (OK=1)
	$Sujet:="Confirmation d'inscription au RAEMA Gel"
	$email:=New object:C1471
	$transporter:=ASAPCreationtransporter 
	$email.from:="asa-spv@wanadoo.fr"
	$email.subject:=$Sujet
	$email.to:="asa-spv@wanadoo.fr,"+$AdEmail+","+$AdEmails
	  //$email.to:="riouall.eloise@orange.fr"
	$email.textBody:=MailDevis
	$status:=$transporter.send($email)  // Envoi du message
	MailOK:=($status.success)
	
Else 
	SET TEXT TO PASTEBOARD:C523(MailDevis)
End if 



  //LISTBOX SUPPRIMER LIGNES(ListBoxNumLabo;ListBoxNumLabo)
ZViderSelectionCourante (->[PersonnesDevis:30])

  // ZAmnistieInternationale 
GA13RaemaGelGrilleInit 
GA15FabriqueTbDevisRAEMAGel 
LISTBOX SELECT ROW:C912(*;"ListBoxNumLabo";0;lk supprimer de sélection:K53:3)