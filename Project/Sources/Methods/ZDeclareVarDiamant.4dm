//%attributes = {"publishedWeb":true}
// ZDéclareVarDiamant 7.0 du 13/01/01, modifiée en V11 le 20/07/2010
// Modifié par : Association QualiSoft (02/05/2018)
// Déclarations des variables standard et des variables interprocess 

//  les interprocess
C_BOOLEAN:C305(<>ZFinirEnBeauté; <>ConnexionActive; <>ZMouchard; <>ZNews; <>ZNewsActifs; <>ZPCServeur)
C_LONGINT:C283(<>TimeOutVerouillage)
C_DATE:C307(<>ZDateDuJour)
C_TIME:C306(<>ZHeureCourante; <>ZHeureDerniereAction)
C_TEXT:C284(<>ZQuiCode; <>ZQuiVaLà; <>ZTAB; <>ZGUIL; <>ZCR; <>ZQuiCodeUUID)
C_TEXT:C284(<>ZPERMMILLE; <>ZCR2; <>AncienMotDePasse; <>ZNomProgramme; <>ZSéparateur)
C_PICTURE:C286(<>FeuVert; <>FeuRouge; <>MarqueVert; <>MarqueRouge)


<>ZNomProgramme:="Standard QualiSoft"
<>ZFinirEnBeauté:=False:C215  // permet de quitter proprement 4D
<>ZMouchard:=True:C214  // Permet l'écritue automatique des logs en cas d'erreur non capturée dans le dossier Logs_base situé au niveau de la structure
<>ZNews:=True:C214  // Affiche la palette de communication
<>ZNewsActifs:=True:C214  // Affiche la palette de communication


//Gestion des boutons

READ PICTURE FILE:C678(Get 4D folder:C485(Current resources folder:K5:16)+Replace string:C233("images/FeuVert.jpg"; "/"; Folder separator:K24:12); <>FeuVert)
READ PICTURE FILE:C678(Get 4D folder:C485(Current resources folder:K5:16)+Replace string:C233("images/FeuRouge.jpg"; "/"; Folder separator:K24:12); <>FeuRouge)
READ PICTURE FILE:C678(Get 4D folder:C485(Current resources folder:K5:16)+Replace string:C233("images/MarqueVerte.jpg"; "/"; Folder separator:K24:12); <>MarqueVerte)
READ PICTURE FILE:C678(Get 4D folder:C485(Current resources folder:K5:16)+Replace string:C233("images/MarqueRouge.jpg"; "/"; Folder separator:K24:12); <>MarqueRouge)

// Variables interprocess standard

//CONSTANTES ASSOCIEES AU MOMENT DE L'OUVERTURE DE LA BASE
<>ZDateDuJour:=Current date:C33  //Date constante même si on traverse minuit pendant la session
<>ZHeureCourante:=Current time:C178
<>ZHeureDerniereAction:=<>ZHeureCourante
<>ZSéparateur:=Folder separator:K24:12
<>ZPCServeur:=(<>ZSéparateur#":")

//Initialisation du tableau  (popup) de Date
// TODO : à voir sir <>POPDate est utilisé dans le standard (à terme)
ARRAY TEXT:C222(<>PopDate; 19)
STRING LIST TO ARRAY:C511(21000; <>PopDate)  // un peu crypto...


<>ZCR:=Char:C90(13)  // Retour chariot
<>ZCR2:=<>ZCR*2
<>ZGuil:="\""  //Guillement
<>ZTab:="\t"
<>ZCRWeb:=<>ZCR+Char:C90(10)

<>ZPermMille:=Substring:C12(String:C10(Year of:C25(<>ZDateDuJour)); System date long:K1:3; 2)
// Extrait le millésime de l'année 99=1999 / 00=2000

<>ZQuiVaLà:=""
<>ZQuiCode:=""
// Initialisation du nom et du code de l'utilisateur connecté


<>ZQuiCodeUUID:=""

<>ZFinirEnBeauté:=False:C215

<>ZVarNews:=""  // Variable Palette

<>ASAP:=True:C214

<>Alfort:=False:C215  // Permet de faire les tests. exemple : inutile de lancer les sauvegardes et autres pages Web

<>CalculTableauxGénérauxEnCours:=False:C215  // Booléen du poste ou du serveur permettant de ne pas interférer
//  lors de la remise à jour des tableaux généraux des campagnes



// tableaux interprocess de variables universelles
// Tableau des jours
ARRAY TEXT:C222(<>ZTbNomDuJour; 7)
<>ZTbNomDuJour{1}:="Dimanche"
<>ZTbNomDuJour{2}:="Lundi"
<>ZTbNomDuJour{3}:="Mardi"
<>ZTbNomDuJour{4}:="Mercredi"
<>ZTbNomDuJour{5}:="Jeudi"
<>ZTbNomDuJour{6}:="Vendredi"
<>ZTbNomDuJour{7}:="Samedi"

// Tableau des mois
ARRAY TEXT:C222(<>ZTbNomDuMois; 12)
<>ZTbNomDuMois{1}:="Janvier"
<>ZTbNomDuMois{2}:="Février"
<>ZTbNomDuMois{3}:="Mars"
<>ZTbNomDuMois{4}:="Avril"
<>ZTbNomDuMois{5}:="Mai"
<>ZTbNomDuMois{6}:="Juin"
<>ZTbNomDuMois{7}:="Juillet"
<>ZTbNomDuMois{8}:="Août"
<>ZTbNomDuMois{9}:="Septembre"
<>ZTbNomDuMois{10}:="Octobre"
<>ZTbNomDuMois{11}:="Novembre"
<>ZTbNomDuMois{12}:="Décembre"

//Ensemble de tableaux utilisés pour l'expression un nom en toutes lettres
ARRAY TEXT:C222(<>ZTBETLUnité; 4)
<>ZTBETLUnité{1}:=""
<>ZTBETLUnité{2}:="mille"
<>ZTBETLUnité{3}:="million"
<>ZTBETLUnité{4}:="milliard"

ARRAY TEXT:C222(<>ZTBETLVingt; 20)
<>ZTBETLVingt{1}:="un"
<>ZTBETLVingt{2}:="deux"
<>ZTBETLVingt{3}:="trois"
<>ZTBETLVingt{4}:="quatre"
<>ZTBETLVingt{5}:="cinq"
<>ZTBETLVingt{6}:="six"
<>ZTBETLVingt{7}:="sept"
<>ZTBETLVingt{8}:="huit"
<>ZTBETLVingt{9}:="neuf"
<>ZTBETLVingt{10}:="dix"
<>ZTBETLVingt{11}:="onze"
<>ZTBETLVingt{12}:="douze"
<>ZTBETLVingt{13}:="treize"
<>ZTBETLVingt{14}:="quatorze"
<>ZTBETLVingt{15}:="quinze"
<>ZTBETLVingt{16}:="seize"
<>ZTBETLVingt{17}:="dix-sept"
<>ZTBETLVingt{18}:="dix-huit"
<>ZTBETLVingt{19}:="dix-neuf"
<>ZTBETLVingt{20}:="vingt"

ARRAY TEXT:C222(<>ZTBETLDix; 10)
<>ZTBETLDix{1}:="dix"
<>ZTBETLDix{2}:="vingt"
<>ZTBETLDix{3}:="trente"
<>ZTBETLDix{4}:="quarante"
<>ZTBETLDix{5}:="cinquante"
<>ZTBETLDix{6}:="soixante"
<>ZTBETLDix{7}:="soixante-dix"
<>ZTBETLDix{8}:="quatre-vingt"
<>ZTBETLDix{9}:="quatre-vingt dix"
<>ZTBETLDix{10}:="cent"
ZInitSaintsCalendrier

