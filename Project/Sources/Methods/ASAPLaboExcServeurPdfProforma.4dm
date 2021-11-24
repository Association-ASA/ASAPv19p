//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : ASA
// Date et heure : 26/02/21, 10:33:53
// ----------------------------------------------------
// Méthode : ASAPLaboExcServeurPdfProforma
// Description
// Créé les pdf des proforma sur le serveur et ajoute
// l'URL dans l'enregistrement des [Personnes]
// ----------------------------------------------------

$NumCampagne:=PUMNumCampagneSuivi{PUMNumCampagneSuivi}
$Prc:=Execute on server:C373("ASAPLaboCreePdfProformaServeur"; 0; "ProformaDansWeb"; $NumCampagne)


//C_ENTIER LONG($Salé;$FT)

//  // initialisation des tableaux des laboratoires avec Proforma
//TABLEAU TEXTE(TbNomLaboratoire;0)
//TABLEAU ENTIER LONG(TbNumLabo;0)
//TABLEAU TEXTE(TbProformaLabo;0)
//TABLEAU TEXTE(TbPoidsColis;0)
//TABLEAU TEXTE(TbDimensionColis;0)
//TABLEAU TEXTE(TbUUIDLabo;0)

//  // Cherchons les colis qui ont une valeur dans TbProforma

//$TT:=Taille tableau(TbProforma)
//CHERCHER([RAEMACampagnes];[RAEMACampagnes]NumCampagne=PUMNumCampagneSuivi{PUMNumCampagneSuivi}
//VarDate:=[RAEMACampagnes]DateEnvoiColis
//  //$NumCampagne:=PUMNumCampagneSuivi{PUMNumCampagneSuivi}
//  //$TypeRaema:=(Num($NumCampagne="@a")*"Gel")+(Num($NumCampagne#"@a")*"Poudre")
//Boucle ($Salé;1;$TT)
//$L:=Chercher dans tableau(<>TbPerNumLaboRAEMA;TbNumLaboN{$Salé})  // Rang dans tableaux généraux personnes
//$identifiantParticipation:=Chaîne(TbNumLaboN{$Salé})+"_"+TbNumCampagne{$Salé}+"_"
//$LP:=Chercher dans tableau(<>TbLotoIdentifiantParticipation;$identifiantParticipation)  // Rang dans tableaux généraux participation
//Si (TbProforma{$Salé}#"") & (<>TbPAAssociation{$L}#"LRAR-M")
//AJOUTER À TABLEAU(TbNomLaboratoire;TbNomLabo{$Salé})
//AJOUTER À TABLEAU(TbNumLabo;TbNumLaboN{$Salé})
//AJOUTER À TABLEAU(TbProformaLabo;TbProforma{$Salé})
//AJOUTER À TABLEAU(TbUUIDLabo;<>TBPerUUID{$L})

//Au cas ou 

//: (TbNumLaboN{$Salé}=469)
//  //(<>TbPAAssociation{$L}="ASA - LRAR-M")  // si "Marocain"  = 6 Kg     45 cm x 37 cm x 25 cm
//VarPoids:="6 Kg"
//VarDim:="40cm x 37cm x 25cm"

//: (TbNumLaboN{$Salé}=32)
//VarPoids:="3 Kg"
//VarDim:="30cm x 30cm x 30cm"

//: (<>TbLotoBoiteIsotherme{$LP}=0) & ((<>TbLotoNbColisPoudreSR{$LP}+<>TbLotoNbColisPoudreAR{$LP})=0)  // si pas isotherme et pas de colis sup = 1 Kg     24 cm x 24 cm x 10 cm
//VarPoids:="1 Kg"
//VarDim:="24cm x 24cm x 10cm"

//: (<>TbLotoBoiteIsotherme{$LP}=0) & ((<>TbLotoNbColisPoudreSR{$LP}+<>TbLotoNbColisPoudreAR{$LP})=1)  // si pas isotherme et 1 colis sup = 3 Kg     25 cm x 25 cm x 25 cm
//VarPoids:="3 Kg"
//VarDim:="25cm x 25cm x 25cm"

//: (<>TbLotoBoiteIsotherme{$LP}=0) & ((<>TbLotoNbColisPoudreSR{$LP}+<>TbLotoNbColisPoudreAR{$LP})=2)  // si pas isotherme et 2 colis sup = 3 Kg    30 cm x 30 cm x 30 cm
//VarPoids:="3 Kg"
//VarDim:="30cm x 30cm x 30cm"

//: (<>TbLotoBoiteIsotherme{$LP}>0) & ((<>TbLotoNbColisPoudreSR{$LP}+<>TbLotoNbColisPoudreAR{$LP})=0)  // si isotherme  = 8 Kg     386 mm x 286 mm x 297 mm
//VarPoids:="8 Kg"
//VarDim:="386mm x 286mm x 297mm"

//: (<>TbLotoBoiteIsotherme{$LP}>0) & ((<>TbLotoNbColisPoudreSR{$LP}+<>TbLotoNbColisPoudreAR{$LP})>0)  // si isotherme  = 10 Kg     386 mm x 376 mm x 337 mm
//VarPoids:="10 Kg"
//VarDim:="386mm x 376mm x 337mm"


//Sinon 

//VarPoids:=""
//VarDim:=""
//Fin de cas 

//$Formulaire:=TbProforma{$Salé}

//Au cas ou 
//: ($Formulaire="Facture") | ($Formulaire="Commercial")
//$Format:="FacCom"

//: ($Formulaire="Proforma")
//$Format:="Proforma"+$TypeRaema
//  //Sinon 
//  //$OI:=Faux
//Fin de cas 

//$NomContact:=OB Lire([Personnes]Arguments;"NomContact";Est un texte)
//$VarPhoneF:=OB Lire([Personnes]Arguments;"PhonePro";Est un texte)
//VarNomTel:=$NomContact+<>ZCR+$VarPhoneF
//LIEN RETOUR([Personnes]UUID)
//CHERCHER([PersonnesAdresses];[PersonnesAdresses]UUIDPersonne=[Personnes]UUID;*)
//CHERCHER([PersonnesAdresses]; & [PersonnesAdresses]TypeAdresse="Livraison")
//VarUUID:=[Personnes]UUID
//$Adr:=""
//Si ([PersonnesAdresses]LigneAdresse1#"")
//$Adr:=$Adr+[PersonnesAdresses]LigneAdresse1+<>ZCR
//Fin de si 
//Si ([PersonnesAdresses]LigneAdresse2#"")
//$Adr:=$Adr+[PersonnesAdresses]LigneAdresse2+<>ZCR
//Fin de si 
//Si ([PersonnesAdresses]LigneAdresse3#"")
//$Adr:=$Adr+[PersonnesAdresses]LigneAdresse3+<>ZCR
//Fin de si 
//Si ([PersonnesAdresses]CodePostal#"")
//$Adr:=$Adr+[PersonnesAdresses]CodePostal+" - "+[PersonnesAdresses]Ville
//Fin de si 
//Si ([PersonnesAdresses]Pays#"") & ([PersonnesAdresses]Pays#"France")
//$Adr:=$Adr+<>ZCR+[PersonnesAdresses]Pays
//Fin de si 
//VarAdresse:=$Adr

//$EORI:=OB Lire([Personnes]Arguments;"EORI";Est un texte)

//Si ($EORI#"")
//VarEORI:=OB Lire([Personnes]Arguments;"EORI";Est un texte)
//Sinon 
//VarEORI:=""
//Fin de si 

//OBJET FIXER VISIBLE(*;"NumSuiviDHL";Faux)
//VarNumSuiviDHL:=""
//CHERCHER([CampagneParticipations];[CampagneParticipations]NumCampagne=PUMNumCampagneSuivi{PUMNumCampagneSuivi};*)
//CHERCHER([CampagneParticipations]; & [CampagneParticipations]UUIDPersonne=[Personnes]UUID)
////$Description:=OBJET Lire titre(*;"Texte6")
//$Transporteur:=OB Lire([CampagneParticipations]Arguments;"Transporteur";Est un texte)
//  //Si ($Transporteur="SIFA")
//  //$Description:=Remplacer chaîne($Description;"EEE";"FRANCE";*)
//  //Fin de si 
//Si ($Transporteur="DHL@")
//VarNumSuiviDHL:=OB Lire([CampagneParticipations]Arguments;"NumSuiviDHL";Est un texte)
//OBJET FIXER VISIBLE(*;"NumSuiviDHL";Vrai)
//Fin de si 
////OBJET FIXER TITRE(*;"Texte6";$Description)

//$Prc:=Exécuter sur serveur("ASAPLaboCreePdfProformaServeurBis";0;"PdfProforma";VarUUID;VarDim;VarPoids;VarDate;VarNomTel;VarAdresse;VarEORI;VarNumSuiviDHL;$Format)
//  //AJOUTER À TABLEAU(TbPoidsColis;$Poids)
//  //AJOUTER À TABLEAU(TbDimensionColis;$Dimensions)

//Fin de si 
//Fin de boucle 


//$NumCampagne:=PUMNumCampagneSuivi{PUMNumCampagneSuivi}
//$TypeRaema:=(Num($NumCampagne="@a")*"Gel")+(Num($NumCampagne#"@a")*"Poudre")
//$FT:=Taille tableau(TbDimensionColis)
//Boucle ($Salé;1;$FT)
//$OI:=Vrai
//$L:=Chercher dans tableau(TbNumLaboN;TbNumLabo{$Salé})
//$Formulaire:=TbProforma{$L}

//Au cas ou 
//: ($Formulaire="Facture") | ($Formulaire="Commercial")
//$Format:="FacCom"

//: ($Formulaire="Proforma")
//$Format:="Proforma"+$TypeRaema

//Sinon 
//$OI:=Faux
//Fin de cas 

//Si ($OI)
//VarPoids:=TbPoidsColis{$Salé}
//VarDim:=TbDimensionColis{$Salé}
//CHERCHER([Personnes];[Personnes]UUID=TbUUIDLabo{$Salé})
//$H:=Imprimer ligne([Personnes];$Format)
//Fin de si 

//ENREGISTREMENT SUIVANT([Personnes])
//  //Fin de boucle 



