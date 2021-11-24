//%attributes = {"lang":"fr"}
ALL RECORDS:C47([Factures:15])
SELECTION TO ARRAY:C260([Factures:15]NumFacture:3; $TbNumFacture)
$TT:=Size of array:C274($TbNumFacture)
ARRAY BOOLEAN:C223($TbFactureAvecAvoir; $TT)
For ($Salé; 1; $TT)
	$L:=Find in array:C230($TbNumFacture; $TbNumFacture{$Salé}+"A")
	If ($L>0) | ($TbNumFacture{$Salé}="@A")
		$TbFactureAvecAvoir{$Salé}:=True:C214
	Else 
		$TbFactureAvecAvoir{$Salé}:=False:C215
	End if 
End for 
ARRAY TO SELECTION:C261($TbNumFacture; [Factures:15]NumFacture:3; $TbFactureAvecAvoir; [Factures:15]Avoir:17)
ALERT:C41("J'ai fini !")

//TOUT SÉLECTIONNER([Factures])
//SÉLECTION VERS TABLEAU([Factures]UUIDPersonne;$TbUUIDPerFac;[Factures]NumFacture;$TbNumFacture;[Factures]LocalitePays;$TbLocalitePays;[Factures]PaysFacturation;$TbPaysFacturation)
//$TT:=Taille tableau($TbUUIDPerFac)
//$Texte:=""
//Boucle ($salé;1;$TT)
//$L:=Chercher dans tableau(<>TBPERUUID;$TbUUIDPerFac{$salé})
//Si ($L>0)
//Si (<>TbPerAdrFacPays{$L}#"")
//$TbPaysFacturation{$salé}:=<>TbPerAdrFacPays{$L}
//Sinon 
//$TbPaysFacturation{$salé}:=<>TbPerAdrLivPays{$L}
//Fin de si 
//Sinon 
//$Texte:=$Texte+$TbNumFacture{$salé}+<>ZCR
//Fin de si 
//Si ($TbPaysFacturation{$salé}#"")
//Au cas ou 
//: ($TbPaysFacturation{$salé}="France")
//$TbLocalitePays{$Salé}:="France"

//: ($TbPaysFacturation{$salé}="@Guadeloupe@") | ($TbPaysFacturation{$salé}="@Reunion@") | ($TbPaysFacturation{$salé}="@Calédonie@") | ($TbPaysFacturation{$salé}="@Polynésie@") | ($TbPaysFacturation{$salé}="@Miquelon@") | ($TbPaysFacturation{$salé}="@Martinique@")
//$TbLocalitePays{$Salé}:="Outre Mer"

//: ($TbPaysFacturation{$salé}="@Saint-Barthélemy@") | ($TbPaysFacturation{$salé}="@Saint-Martin@") | ($TbPaysFacturation{$salé}="@Wallis-et-Futuna@") | ($TbPaysFacturation{$salé}="@Mayotte@")
//$TbLocalitePays{$Salé}:="Outre Mer"

//: ($TbPaysFacturation{$salé}#"France")
//$TbLocalitePays{$Salé}:="Etrangers"
//Fin de cas 
//Sinon 
//$TbLocalitePays{$Salé}:=""
//Fin de si 
//Fin de boucle 
//TABLEAU VERS SÉLECTION($TbUUIDPerFac;[Factures]UUIDPersonne;$TbNumFacture;[Factures]NumFacture;$TbLocalitePays;[Factures]LocalitePays;$TbPaysFacturation;[Factures]PaysFacturation)
//FIXER TEXTE DANS CONTENEUR($Texte)
//CHERCHER([Personnes];[Personnes]TypePersonne="Laboratoire";*)
//CHERCHER([Personnes]; & [Personnes]Caduc=Faux)
//$FT:=Enregistrements trouvés([Personnes])

//CHERCHER([Personnes];[Personnes]TypePersonne="Laboratoire";*)
//CHERCHER([Personnes]; & [Personnes]Caduc=Faux;*)
//CHERCHER PAR ATTRIBUT([Personnes]; & ;[Personnes]Arguments;"FacturationPays";=;Null)
//$FTT:=Enregistrements trouvés([Personnes])
//SÉLECTION VERS TABLEAU([Personnes]UUID;$TbUUIDPersonne)
//TABLEAU ENTIER($TbLabo;0)
//Boucle ($salé;1;$FTT)
//$L:=Chercher dans tableau(<>TBPERUUID;$TbUUIDPersonne{$salé})
//AJOUTER À TABLEAU($TbLabo;<>TbPerNumLaboRAEMA{$L})
//Fin de boucle 

//CHERCHER PAR ATTRIBUT([XTachesDeFond];[XTachesDeFond]ObjetTdF;"DateHeureDebutExécution";=;Date du jour;*)
//CHERCHER PAR ATTRIBUT([XTachesDeFond]; & ;[XTachesDeFond]ObjetTdF;"NomMéthode";=;"RapPlaceDocumentsDansWeb";*)
//CHERCHER PAR ATTRIBUT([XTachesDeFond]; & ;[XTachesDeFond]ObjetTdF;"Accompli";=;Vrai)
//  //CHERCHER([Personnes];[Personnes]TypePersonne="Laboratoire";*)
//  //CHERCHER([Personnes]; & [Personnes]Caduc=Faux)
//$FT:=Enregistrements trouvés([Personnes])
//LECTURE ÉCRITURE([Personnes])
//$AdresseRapport:=""
//Boucle ($salé;1;$FT)
//$AdresseRapport:=OB Lire([Personnes]Arguments;"EmailRAEMA")
//Si ($AdresseRapport#"")
//OB FIXER([Personnes]Arguments;"EmailLivraison";$AdresseRapport)
//STOCKER ENREGISTREMENT([Personnes])
//Fin de si 
//ENREGISTREMENT SUIVANT([Personnes])
//Fin de boucle 
//ZAmnistiePartielle (->[Personnes])
//ALERTE("J'ai fini !")
//CHERCHER([Personnes];[Personnes]TypePersonne="Laboratoire";*)
//CHERCHER([Personnes]; & [Personnes]Caduc=Faux;*)
//CHERCHER PAR ATTRIBUT([Personnes]; & ;[Personnes]Arguments;"FacturationPays";=;Null)
//$FT:=Enregistrements trouvés([Personnes])
//LECTURE ÉCRITURE([Personnes])
//Boucle ($Salé;1;$FT)
//$L:=Chercher dans tableau(<>TBPERUUID;[Personnes]UUID)
//Si ($L>0)
//$Pays:=<>TbPerAdrLivPays{$L}
//Si ($Pays#"")
//Si ($Pays="FRANCE")
//OB FIXER([Personnes]Arguments;"FacturationPays";"France")
//Sinon 
//OB FIXER([Personnes]Arguments;"FacturationPays";"Etrangers")
//Fin de si 
//STOCKER ENREGISTREMENT([Personnes])
//Fin de si 
//Fin de si 
//ENREGISTREMENT SUIVANT([Personnes])
//Fin de boucle 
//ZAmnistiePartielle (->[Personnes])
//  //SÉLECTION VERS TABLEAU([Personnes]UUID;$TbUUIDPersonne)
//  //$TT:=Taille tableau($TbUUIDPersonne)
//  //TABLEAU TEXTE($TbNumLabo;$TT)
//  //TABLEAU TEXTE($TbPays;$TT)
//  //$Export:=""
//Boucle ($Salé;1;$TT)
//$TbNumLabo{$Salé}:=ASAPTrouveNumeroLaboParUUID ($TbUUIDPersonne{$Salé})
//$L:=Chercher dans tableau(<>TBPERUUID;$TbUUIDPersonne{$Salé})
//$TbPays{$Salé}:=<>TbPerAdrLivPays{$L}
//$Export:=$Export+$TbNumLabo{$Salé}+<>Ztab+$TbPays{$Salé}+<>ZCR
//Fin de boucle 
//FIXER TEXTE DANS CONTENEUR($Export)
//    
//$Date:=!30/11/2021!
//$Date1:=Ajouter à date($Date;0;0;30)
//$MoisRèglement:=Mois de($Date1)
//Au cas ou 
//: ($MoisRèglement=1)
//$MoisPlus1:=2
//$Année:=Année de($Date)+1

//: ($MoisRèglement=12)
//$MoisPlus1:=1
//$Année:=Année de($Date)+1

//Sinon 
//$MoisPlus1:=$MoisRèglement+1
//$Année:=Année de($Date)
//Fin de cas 
//$Date2:=Date("01/"+Chaîne($MoisPlus1)+"/"+Chaîne($Année))
//$DateRèglement:=Ajouter à date($Date2;0;0;-1)

//$MoisRèglement:=Num(Sous chaîne($Date;4;2))
//Au cas ou 
//: ($MoisRèglement)<9
//$MoisPlus1:="0"+Chaîne(Num($MoisRèglement)+1)
//Si ($MoisPlus1="01") | ($MoisPlus1="03") | ($MoisPlus1="05") | ($MoisPlus1="07") | ($MoisPlus1="08") | ($MoisPlus1="10")
//$Jour:="31"
//Fin de si 
//Si ($MoisPlus1="04") | ($MoisPlus1="06") | ($MoisPlus1="09") | ($MoisPlus1="11")
//$Jour:="30"
//Fin de si 
//Si ($MoisPlus1="02")
//$Jour:="28"
//Fin de si 
//$DateRèglement:=$Jour+"/"+$MoisPlus1+"/"+Chaîne(Année de(Date du jour))

//: ($MoisRèglement)=12
//$DateRèglement:="31/01/"+Chaîne(Num(Année de(Date du jour)+1))

//Sinon 
//$MoisPlus1:=Chaîne(Num($MoisRèglement)+1)
//$DateRèglement:=$Jour+"/"+$MoisPlus1+"/"+Chaîne(Année de(Date du jour))
//Fin de cas 

// Attention à l'année si janvier



//CHERCHER([CampagneParticipations];[CampagneParticipations]NumCampagne="73A")
//  //CHERCHER([CampagneParticipations]; | [CampagneParticipations]NumCampagne="73A")

//$FT:=Enregistrements trouvés([CampagneParticipations])
//LECTURE ÉCRITURE([CampagneParticipations])
//Boucle ($Salé;1;$FT)
//CHERCHER([Personnes];[Personnes]UUID=[CampagneParticipations]UUIDPersonne)
//$NomTransporteur:=OB Lire([Personnes]Arguments;"ModeEnvoiColis";Est un texte)
//OB FIXER([CampagneParticipations]Arguments;"Transporteur";Majusc($NomTransporteur))
//STOCKER ENREGISTREMENT([CampagneParticipations])
//ENREGISTREMENT SUIVANT([CampagneParticipations])
//Fin de boucle 
//ALERTE("Fini !")
//ZAmnistieInternationale 


//CHERCHER([Personnes];[CampagneParticipations]NumCampagne="72A")
//SÉLECTION VERS TABLEAU([Personnes]UUID;$Tb72A)
//CHERCHER([Personnes];[CampagneParticipations]NumCampagne="72")
//SÉLECTION VERS TABLEAU([Personnes]UUID;$Tb72)
//TABLEAU TEXTE($TbLaboQueGel;0)
//$TT:=Taille tableau($Tb72A)
//$Test:=0
//Boucle ($Salé;1;$TT)
//$L:=Chercher dans tableau($Tb72;$Tb72A{$Salé})
//Si ($L<0)
//$NumLabo:=ASAPTrouveNumeroLaboParUUID($Tb72A{$Salé})
//AJOUTER À TABLEAU($TbLaboQueGel;$NumLabo)
//Sinon 
//$Test:=$Test+1
//Fin de si 
//Fin de boucle 
//TRACE

//CHERCHER([Factures];[Factures]PaysFacturation="")
//$FT:=Enregistrements trouvés([Factures])
//LECTURE ÉCRITURE([Factures])
//Boucle ($Salé;1;$FT)
//$L:=Chercher dans tableau(<>TBPerUUID;[Factures]UUIDPersonne)
//[Factures]PaysFacturation:=<>TbPerAdrFacPays{$L}
//  //Si (<>TbPerAdrProPays{$L}#"")
//  //[Factures]PaysFacturation:=<>TbPerAdrProPays{$L}
//  //Fin de si 
//  //Si (<>TbPerAdrPerPays{$L}#"")
//  //[Factures]PaysFacturation:=<>TbPerAdrPerPays{$L}
//  //Fin de si
//STOCKER ENREGISTREMENT([Factures])
//ENREGISTREMENT SUIVANT([Factures])
//Fin de boucle 
//ALERTE("Fini !")
//$TT:=Taille tableau(<>TbLotoIdentifiantParticipation)
//$Message:=""
//Boucle ($Salé;1;$TT)
//Si (<>TbLotoIdentifiantParticipation{$Salé}="@72A@")
//$Pos:=Position("_";<>TbLotoIdentifiantParticipation{$Salé})
//$Valeur:=Sous chaîne(<>TbLotoIdentifiantParticipation{$Salé};1;($Pos-1))
//$Message:=$Message+$Valeur+<>ZCR
//Fin de si 
//Fin de boucle 
//FIXER TEXTE DANS CONTENEUR($Message)
//ALERTE("J'ai fini")

//CHERCHER([Personnes];[Personnes]TypePersonne="Laboratoire";*)
//CHERCHER([Personnes]; & [Personnes]Caduc=Faux)
//SÉLECTION VERS TABLEAU([Personnes]UUID;$TbUUIDLabo)
//$CDDoc:=Sélectionner dossier("Où voulez-vous recopier les photos ?")
//$CD:=$CDDoc+"Mails labo carte voeux"
//$DocF:=Créer document($CD)
//$TT:=Taille tableau($TbUUIDLabo)
//$Doc:=""
//Boucle ($salé;1;$TT)
//$L:=Chercher dans tableau(<>TbPerUUID;$TbUUIDLabo{$salé})
//Si ($L>0)
//$EMail:=<>TbPAEMail{$L}
//Si ($EMail#"")
//$EMailPV:=Remplacer chaîne($EMail;",";<>ZCR)
//$EMailFinal:=$EMailPV+<>ZCR
//$Doc:=$Doc+$EMailFinal
//Fin de si 
//Fin de si 
//Fin de boucle 
//ENVOYER PAQUET($DocF;$Doc)

//$Sujet:="Envoi des mails des laboratoires pour carte de voeux"
//$email:=Créer objet
//$transporter:=ASAPCreationtransporter 
//$email.from:="asa-spv@wanadoo.fr"
//$email.subject:=$Sujet
//$email.to:="riouall.eloise@orange.fr,asa-spv@wanadoo.fr"
//$email.textBody:=$Doc
//$status:=$transporter.send($email)  // Envoi du message
//MailOK:=($status.success)
//TRACE
//$Doc:=""

//CHERCHER([Personnes];[Personnes]TypePersonne="Individu";*)
//CHERCHER([Personnes]; & [Personnes]Caduc=Faux;*)
//CHERCHER([Personnes]; & [Factures]NumFacture="19/C@")

//SÉLECTION VERS TABLEAU([Personnes]UUID;$TbUUIDLabo)
//$TT:=Taille tableau($TbUUIDLabo)
//$CDDoc:=Sélectionner dossier("Où voulez-vous recopier les photos ?")
//$CD:=$CDDoc+"Mails adhérents carte voeux"
//$DocF:=Créer document($CD)
//$Doc:=""
//Boucle ($salé;1;$TT)
//$L:=Chercher dans tableau(<>TbPerUUID;$TbUUIDLabo{$salé})
//Si ($L>0)
//$EMail:=<>TbPAEMail{$L}
//Si ($EMail#"")
//$EMailPV:=Remplacer chaîne($EMail;",";<>ZCR)
//$EMailFinal:=$EMailPV+<>ZCR
//$Doc:=$Doc+$EMailFinal
//Fin de si 
//Fin de si 
//Fin de boucle 
//ENVOYER PAQUET($DocF;$Doc)
//  //$Sujet:="Envoi des mails des adhérents pour carte de voeux"
//$email:=Créer objet
//$transporter:=ASAPCreationtransporter 
//$email.from:="asa-spv@wanadoo.fr"
//$email.subject:=$Sujet
//$email.to:="riouall.eloise@orange.fr,asa-spv@wanadoo.fr"
//$email.textBody:=$Doc
//$status:=$transporter.send($email)  // Envoi du message
//MailOK:=($status.success)
//$Doc:=""



If (False:C215)
	//TOUT SÉLECTIONNER([CourrielsTypes])
	//  //$FT:=Enregistrements trouvés([CourrielsTypes])
	//  //TABLEAU ENTIER LONG($TbNum;$FT)
	//  //Boucle ($Salé;1;$FT)
	//  //$TbNum{$Salé}:=$Salé
	//  //Fin de boucle 
	//  //TABLEAU VERS SÉLECTION($TbNum;[CourrielsTypes]NumLettre)
	
	//FIXER PARAMÈTRE BASE([CourrielsTypes];31;Enregistrements trouvés([CourrielsTypes]))
	//$NA:=Numérotation automatique([CourrielsTypes])
	
	
	
	//LECTURE ÉCRITURE([Factures])
	//CHERCHER([Factures];[Ventes]DateReglement#"")
	//$FT:=Enregistrements trouvés([Factures])
	//Boucle ($salé;1;$FT)
	//[Factures]Regle:=Vrai
	//STOCKER ENREGISTREMENT([Factures])
	//ENREGISTREMENT SUIVANT([Factures])
	//Fin de boucle 
	//ZAmnistieInternationale 
	//ALERTE("J'ai fini !")
	
	
	// $0:=OB Lire([Personnes]Arguments;"Association";Est un texte)
	//FORM FIXER SORTIE([Personnes];"ListeTout")
	//IMPRIMER SÉLECTION([Personnes];*)
	
	//C_ENTIER LONG($Salé;$FT)
	//CHERCHER([Prestations];[Prestations]AnneePrestation=2018;*)
	//CHERCHER([Prestations]; & [Prestations]CodePrestation#"")
	//TABLEAU ENTIER LONG SUR SÉLECTION([Prestations];$TbNumEnrPrest)
	
	//$Ft:=Taille tableau($TbNumEnrPrest)
	//Boucle ($Salé;1;$FT)
	//ALLER À ENREGISTREMENT([Prestations];$TbNumEnrPrest{$Salé})
	//DUPLIQUER ENREGISTREMENT([Prestations])
	//[Prestations]AnneePrestation:=2019
	//STOCKER ENREGISTREMENT([Prestations])
	//Fin de boucle 
	
	
	
	
	
	//C_ENTIER LONG($Salé;$FT)
	//TABLEAU OBJET($TbArg;0)
	//CHERCHER([CampagneParticipations];[CampagneParticipations]NumCampagne="66")
	//SÉLECTION VERS TABLEAU([CampagneParticipations]UUIDPersonne;$TbUUID;[CampagneParticipations]Arguments;$TbArg)
	//TABLEAU ENTIER LONG SUR SÉLECTION([CampagneParticipations];$TbNumEnr)
	//$FT:=Taille tableau($TbNumEnr)
	//TABLEAU TEXTE($TbCodeLiaison;$FT)
	//TABLEAU TEXTE($TbNumLaboA;$FT)
	//Boucle ($Salé;1;$FT)
	//$TbCodeLiaison{$Salé}:=OB Lire($TbArg{$Salé};"CodeRaemaLié";Est un texte)
	//$TbNumLaboA{$Salé}:=WebTrouveValeurParNom ($TbUUID{$Salé};-><>TbPerUUID;-><>TbPerNumLaboRAEMAA)
	//Fin de boucle 
	//TRIER TABLEAU($TbNumLaboA;$TbCodeLiaison;$TbUUID;>)
	//$Rapport:=""
	//Boucle ($Salé;1;$FT)
	//$rapport:=$Rapport+$TbUUID{$Salé}+<>ZTab+$TbCodeLiaison{$Salé}+<>ZTab+$TbNumLaboA{$Salé}+<>ZCR
	//Fin de boucle 
	//  // FIXER TEXTE DANS CONTENEUR($Rapport)
	//Si (Faux)
	
	//CHERCHER([CampagneParticipations];[CampagneParticipations]NumCampagne="67";*)
	//CHERCHER PAR ATTRIBUT([CampagneParticipations]; & ;[CampagneParticipations]Arguments;"Sauvage";=;Faux)
	
	
	//CHERCHER PAR ATTRIBUT([Personnes];[Personnes]Arguments;"TbNumRAEMALié";#;Null)
	
	//APPLIQUER À SÉLECTION([RAEMACampagnes];OB FIXER TABLEAU([RAEMACampagnes]Arguments;"TbDilution";<>TbDilution))
	
	//  //FIXER TEXTE DANS CONTENEUR(ZTableauVersTexte (-><>TbF))
	//  //FIXER TEXTE DANS CONTENEUR(ZTableauVersTexte (-><>TbA))
	//NumCampagneCourante:="67"
	//LangueCourante:="F"
	//ResP2HtmlLigneTitre ("01")
	
	
	//ASAPObjetNomProprio (->[RAEMAValeurs]Arguments)
	
	//C_BOOLÉEN($esc)
	//CHERCHER PAR ATTRIBUT([RAEMALignes];[RAEMALignes]Arguments;"ChoixMultiple";=;Vrai)
	//$esc:=OB Lire([RAEMALignes]Arguments;"ChoixMultiple";Est un booléen)
	//LECTURE ÉCRITURE([Personnes])
	//TOUT SÉLECTIONNER([Personnes])
	//APPLIQUER À SÉLECTION([Personnes];[Personnes]ChampRecherche:=ASAPSurValidationSaisieLabo )
	//ZAmnistieInternationale 
	
	
	
	//C_ENTIER LONG($Salé;$FT)
	//TOUT SÉLECTIONNER([Personnes])
	//TABLEAU TEXTE($TbProprietes;0)
	
	//$FT:=Enregistrements trouvés([Personnes])
	
	//Boucle ($Salé;1;$FT)
	
	//OB LIRE NOMS PROPRIÉTÉS([Personnes]Arguments;$TbArgument)
	//$SFT:=Taille tableau($TbArgument)
	//Boucle ($Fumé;1;$SFT)
	//Si (Chercher dans tableau($TbProprietes;$TbArgument{$Fumé})=-1)
	//AJOUTER À TABLEAU($TbProprietes;$TbArgument{$Fumé})
	//Fin de si 
	//Fin de boucle 
	//Fin de boucle 
	//$T:=ZTableauVersTexte (->$TbProprietes)
	//  //FIXER TEXTE DANS CONTENEUR($T)
	
	
	
	//C_OBJET($Objet)
	//OB FIXER($Objet;"NomTâche";"Coucou";"NomMéthode";"AaaaaaMethode";"NumTable";1;"Destinataire";"PE";"NumEnr";1)
	//ZTacheDeFondLancer ($Objet)
	
	
	//  // affectation du descriptif de [XAttributions]
	//C_ENTIER LONG($Salé;$FT)
	//LECTURE ÉCRITURE(*)
	//TOUT SÉLECTIONNER([XAttributions])
	
	//$FT:=Enregistrements trouvés([XAttributions])
	
	//Boucle ($Salé;1;$FT)
	
	//STOCKER ENREGISTREMENT([XAttributions])
	//ENREGISTREMENT SUIVANT([XAttributions])
	//Fin de boucle 
	
	
	
	
	
	//TOUT SÉLECTIONNER([XUtilisateurs])
	//Tant que (Non(Fin de sélection([XUtilisateurs])))
	//LIEN RETOUR([XUtilisateurs]UUID)
	//SÉLECTION VERS TABLEAU([XAttributions]UUIDFonction;TbUUIDFonction)
	//ZDroitsRecalcule (Vrai;Vrai)
	//STOCKER ENREGISTREMENT([XUtilisateurs])
	//ENREGISTREMENT SUIVANT([XUtilisateurs])
	//Fin tant que 
	//Fin de si 
	//ZAmnistieInternationale 
End if 
