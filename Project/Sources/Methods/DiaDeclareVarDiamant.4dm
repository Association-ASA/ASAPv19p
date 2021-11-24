//%attributes = {"publishedWeb":true}
  // ZDéclareVarDiamant  6.0 du 12/8/98
  // Déclarations des variables standard
  //Appelé dans ZDebut

C_LONGINT:C283($Salé;$FT)

<>NAD:=0
<>ConnaissanceDeBase:=False:C215  // booleen de présence de connaissance de base

<>Boss:=True:C214
  // Variables globales de traductions
  //LangueEnCours:="F"
  //TABLEAU TEXTE(<>TbF;0)
  //TABLEAU TEXTE(<>TbA;0)
  //CHERCHER([XDonnees];[XDonnees]XNom="Traductions";*)
  //CHERCHER([XDonnees]; & [XDonnees]XType="Ad3")
  //BlobVersVariable (->[XDonnees]XBlob;-><>TbF;-><>TbA)

  //LECTURE ÉCRITURE([XDonnees])
QUERY:C277([DiaData:45];[DiaData:45]XNom:1="TbTraducListeLesion";*)
QUERY:C277([DiaData:45]; & [DiaData:45]XType:5="TbTra")
ARRAY TEXT:C222(<>TbNLF;0)  // Nom de la lésion
ARRAY TEXT:C222(<>TbNLA;0)
ARRAY TEXT:C222(<>TbDMF;0)  // description macro
ARRAY TEXT:C222(<>TbDMA;0)
ARRAY TEXT:C222(<>TbFRF;0)  // Fiche reflexe
ARRAY TEXT:C222(<>TbFRA;0)
ARRAY TEXT:C222(<>TbNumLes;0)
ARRAY LONGINT:C221(<>TbNumLesN;0)

  //BlobVersVariable (->[XDonnees]XBlob;-><>TbNLF;-><>TbNLE;-><>TbDMF;-><>TbDME;-><>TbFRF;-><>TbFRE;-><>TbNumLes)
  //$FT:=Taille tableau(<>TbNumLes)
  //TABLEAU ENTIER LONG(<>TbNumLesN;$FT)
  //Boucle ($Salé;1;$FT)
  //<>TbNumLesN{$Salé}:=Num(<>TbNumLes{$Salé})
  //Fin de boucle

  //OB FIXER TABLEAU([XDonnees]XObjet;"TbNomLesF";<>TbNLF)
  //OB FIXER TABLEAU([XDonnees]XObjet;"TbNomLesE";<>TbNLE)
  //OB FIXER TABLEAU([XDonnees]XObjet;"TbDesLesF";<>TbDMF)
  //OB FIXER TABLEAU([XDonnees]XObjet;"TbDesLesE";<>TbDME)
  //OB FIXER TABLEAU([XDonnees]XObjet;"TbFreLesF";<>TbFRF)
  //OB FIXER TABLEAU([XDonnees]XObjet;"TbFreLesE";<>TbFRE)
  //OB FIXER TABLEAU([XDonnees]XObjet;"TbNumLesA";<>TbNumLes)
  //OB FIXER TABLEAU([XDonnees]XObjet;"TbNumLesN";<>TbNumLesN)
  //STOCKER ENREGISTREMENT([XDonnees])

OB GET ARRAY:C1229([DiaData:45]XObjet:15;"TbNomLesF";<>TbNLF)
OB GET ARRAY:C1229([DiaData:45]XObjet:15;"TbNomLesE";<>TbNLA)
OB GET ARRAY:C1229([DiaData:45]XObjet:15;"TbDesLesF";<>TbDMF)
OB GET ARRAY:C1229([DiaData:45]XObjet:15;"TbDesLesE";<>TbDMA)
OB GET ARRAY:C1229([DiaData:45]XObjet:15;"TbFreLesF";<>TbFRF)
OB GET ARRAY:C1229([DiaData:45]XObjet:15;"TbFreLesE";<>TbFRA)
OB GET ARRAY:C1229([DiaData:45]XObjet:15;"TbNumLesA";<>TbNumLes)
OB GET ARRAY:C1229([DiaData:45]XObjet:15;"TbNumLesN";<>TbNumLesN)
  // La traduction en russe des lésions
$FT:=Size of array:C274(<>TbNumLes)
ARRAY TEXT:C222(<>TbNLR;$FT)
ARRAY TEXT:C222(<>TbDMR;$FT)
ARRAY TEXT:C222(<>TbFRR;$FT)
OB GET ARRAY:C1229([DiaData:45]XObjet:15;"TbNomLesR";<>TbNLR)
OB GET ARRAY:C1229([DiaData:45]XObjet:15;"TbDesLesR";<>TbDMR)
OB GET ARRAY:C1229([DiaData:45]XObjet:15;"TbFreLesR";<>TbFRR)


  // La traduction des textes
  //LECTURE ÉCRITURE([XDonnees])
ARRAY TEXT:C222(<>TbRefTexte;0)  //  texte de référence
ARRAY TEXT:C222(<>TbTexteF;0)  //  texte en français
ARRAY TEXT:C222(<>TbTexteA;0)  //  texte en anglais
ARRAY TEXT:C222(<>TbTexteR;0)  //  texte en russe
QUERY:C277([DiaData:45];[DiaData:45]XNom:1="TbTraducTexte";*)
QUERY:C277([DiaData:45]; & [DiaData:45]XType:5="TbTra")
  // BlobVersVariable (->[XDonnees]XBlob;-><>TbTexteF;-><>TbTexteE;-><>TbTexteR)
  // OB FIXER TABLEAU([XDonnees]XObjet;"TbTexteR";<>TbTexteR)
  // actualisation des tableaux de traductions des textes
OB GET ARRAY:C1229([DiaData:45]XObjet:15;"TbRefTexte";<>TbRefTexte)
OB GET ARRAY:C1229([DiaData:45]XObjet:15;"TbTexteF";<>TbTexteF)
OB GET ARRAY:C1229([DiaData:45]XObjet:15;"TbTexteE";<>TbTexteA)
OB GET ARRAY:C1229([DiaData:45]XObjet:15;"TbTexteR";<>TbTexteR)
  // STOCKER ENREGISTREMENT([XDonnees])
  // ZAmnistiePartielle (->[XDonnees])


  // Paramètres de visualisation
<>PasSelection:=False:C215
<>PaletteVisible:=False:C215
<>VisualisePanier:=True:C214
<>LancePanorama:=False:C215
<>PermNomProgramme:="ASADIA"
<>RadCom:=0
<>RadLes:=0
<>RadFR:=0
<>RadCom:=0
<>RadNPC:=0
<>RadReg:=0
<>VarCom:=""
QUERY:C277([DiaData:45];[DiaData:45]XNom:1="Paramètres de visualisation";*)
QUERY:C277([DiaData:45]; & [DiaData:45]XType:5="Par")
If (Records in selection:C76([DiaData:45])=0)
	CREATE RECORD:C68([DiaData:45])
	[DiaData:45]XNom:1:="Paramètres de visualisation"
	[DiaData:45]XType:5:="Par"
	[DiaData:45]XTexte:7:="1"
	SAVE RECORD:C53([DiaData:45])
End if 
<>VarImageR7:=[DiaData:45]XImage:6
<>AfficheNomLésion:=([DiaData:45]XTexte:7="1")
<>DémarrageFormation:=[DiaData:45]XBool:9
UNLOAD RECORD:C212([DiaData:45])
<>OnVaAuPremier:=False:C215
<>Avance:=False:C215
<>PermLecteur:=False:C215
<>PermCheminDossierO:="Asa:"  // initialisé pour une structure de sauvegarde des images sur un disuqe Asa
<>PermCheminDossierR:=""  // initialisé comme nom du dossier recepteur
  //  les interprocess
C_TEXT:C284(<>ZPERMMILLE;<>ZCR2;<>ZQUICODE;<>ZQUIVALA;<>ZTAB;<>ZCR;<>ZGUIL)
C_BOOLEAN:C305(<>ZPERMWRITE;<>ZGRANDECRAN;<>OnFermePCo)
<>OnFermePCo:=False:C215
<>SéancePhoto:=False:C215

<>ZCR:=Char:C90(13)  // Retour chariot
<>ZCR2:=<>ZCR+<>ZCR
<>ZGuil:=Char:C90(34)  //Guillement
<>ZTab:=Char:C90(9)
<>ZInsec:=Char:C90(160)  // Blanc insécable
<>ZBoiSansSon:=1
  // 0 = Active les sons de destruction
  // 1 = annule les sons de destruction
  // Peut prendre une valeur de [XDonnées] si on désire gérer les sons

<>ZPermMille:=Substring:C12(String:C10(Year of:C25(Current date:C33));3;2)
  // Extrait le millésime de l'année 99=1999 / 00=2000

<>ZQuiVaLà:=""
  // Initiale le nom de l'utilisateur connecté
  // <>ZNomPoste:=ZfRécupNomPoste 
<>FinirEnBeauté:=False:C215  // booléen de sortie


  // Initialisation de <>PermCheDropBox = chemin de la DropBox locale
$Chem:=ZDocNomFichier (System folder:C487(Bureau:K41:16);1)
<>PermCheDropBox:=$Chem+"Dropbox"+Séparateur dossier:K24:12
$OK:=Test path name:C476(<>PermCheDropBox)

  // initialisation des chemins des dossiers de gestion des images dans la DB
<>CDPhotosSauveAsaDia:=<>PermCheDropBox+"SauveAsaDia"+Séparateur dossier:K24:12\
+"PhotosAsaDia"+Séparateur dossier:K24:12
<>CDDBAsaDia:=<>PermCheDropbox+"AsaDia"+Séparateur dossier:K24:12+"Photos approuvées"+Séparateur dossier:K24:12
<>CDTags:=<>CDDBAsaDia+"Tags"+Séparateur dossier:K24:12
<>CDPhotosATraiter:=<>CDDBAsaDia+"Photos à traiter"+Séparateur dossier:K24:12
<>CDPhotosTraitées:=<>CDDBAsaDia+"Photos traitées"+Séparateur dossier:K24:12
<>CDPhotosIgnorées:=<>CDDBAsaDia+"Photos ignorées"+Séparateur dossier:K24:12
<>CDPhotosWeb:=<>CDDBAsaDia+"Photos Web"+Séparateur dossier:K24:12
<>PermCheDossierAsaDiaWeb:=Get 4D folder:C485(Dossier racine HTML:K5:20)+"PhotosAsaDia"+Séparateur dossier:K24:12

ZViderSelectionCourante (->[DiaData:45])
<>VarImageVide:=[DiaData:45]XImage:6

If (<>Ajar)
	  // Initialisation du chemin des pièces-jointes de ASAP sur le Web
	<>PermCheDosPJCourrielWeb:=Get 4D folder:C485(Dossier racine HTML:K5:20)+"PJCourriels"+Séparateur dossier:K24:12
	If (Test path name:C476(<>PermCheDosPJCourrielWeb)<0)  // c'est le chemin de dossier des téléchargements du site Web
		CREATE FOLDER:C475(<>PermCheDosPJCourrielWeb)
	End if 
	
	  // Initialisation du chemin des pièces-jointes de ASAP dans la DB
	<>PermCheDosPJCourrielSource:=<>PermCheDropBox+"SynchroBases"+Séparateur dossier:K24:12+"DossierPJCourriels"+Séparateur dossier:K24:12
	If (Test path name:C476(<>PermCheDosPJCourrielSource)<0)  // c'est le chemin de dossier des téléchargements du site Web
		CREATE FOLDER:C475(<>PermCheDosPJCourrielSource)
	End if 
	
	<>PermCheDossierAsaDiaQuizz:=<>PermCheDossierAsaDiaWeb+"ImagesQuizz"+Séparateur dossier:K24:12
	If (Test path name:C476(<>PermCheDossierAsaDiaQuizz)#Est un dossier:K24:2)
		CREATE FOLDER:C475(<>PermCheDossierAsaDiaQuizz)
	End if 
	
End if 
ARRAY TEXT:C222(<>TbSigleInstitution;8)
ARRAY TEXT:C222(<>TbNomInstitution;8)
ARRAY TEXT:C222(<>TbInitialeInstitution;8)
<>TbSigleInstitution{1}:="vas"
<>TbNomInstitution{1}:="VetAgro Sup"
<>TbInitialeInstitution{1}:="M"

<>TbSigleInstitution{2}:="envn"
<>TbNomInstitution{2}:="ONIRIS"
<>TbInitialeInstitution{2}:="N"

<>TbSigleInstitution{3}:="envt"
<>TbNomInstitution{3}:="ENVT"
<>TbInitialeInstitution{3}:="T"

<>TbSigleInstitution{4}:="ulg"
<>TbNomInstitution{4}:="ULG"
<>TbInitialeInstitution{4}:="L"

<>TbSigleInstitution{5}:="enva"
<>TbNomInstitution{5}:="ENVA"
<>TbInitialeInstitution{5}:="A"

<>TbSigleInstitution{6}:="asa"
<>TbNomInstitution{6}:="ASA"
<>TbInitialeInstitution{6}:="S"

<>TbSigleInstitution{7}:="ISVEK"
<>TbNomInstitution{7}:="Institut Des Sciences Vétérinaires El Khroub"
<>TbInitialeInstitution{7}:="C"

<>TbSigleInstitution{8}:="Abattoir"
<>TbNomInstitution{8}:="Abattoir"
<>TbInitialeInstitution{8}:="B"

DiaWebCreerTbDescriptionPhotos 
