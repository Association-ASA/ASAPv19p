//%attributes = {"publishedWeb":true}
  // ZGèreListe 6.0 du 30/08/98
  //   Procédure globale qui permet de piloter l'utilisateur
  //suppose que les formats $2 & $3 possèdent les boutons voulus
  // et la variable VarNbFic dans l'en-tête qui sert à dénombrer les fiches
  //$1= pointeur de la rubrique discriminante
  // FORMATS LISTES $2=liste  d'affichage $3= liste impression $4 = liste visu
  // FORMATS PAGES $5= saisie $6= impression en page
  // $7= nom du format saisie liste dans [XDonnées]; "" si non
  // $8= procédure de destruction "" sinon

C_TEXT:C284($2;$3;$4;$5;$6;$7;$8)  // noms des formats ou des procédures
C_TEXT:C284(ZNomChaDis;ZNomTable;ZNomForImpLis;ZBoumProc)
C_TEXT:C284(ZNomForAffLis;ZNomForAffSai;ZNomForImpLis)
C_LONGINT:C283(ZNumTable;ZNbEnr)

ZNumTable:=Table:C252($1)
ZPtTable:=Table:C252(ZNumTable)
ZPtChamp:=$1
ZNomChaDis:=Field name:C257($1)
ZNomTable:=Table name:C256(ZPtTable)
ZTypEns:=String:C10(Table:C252(ZPtTable))  // identifie par le numéro de fichier les ensembles crées

  // ZMAJPrivilèges (ZPtTable)
ZNbEnr:=Records in selection:C76(ZPtTable->)
If (ZNbEnr=0)  //autant ne pas afficher une liste vide
	ALL RECORDS:C47(ZPtTable->)
	ZNbEnr:=Records in table:C83(ZPtTable->)
End if 
CREATE SET:C116(ZPtTable->;"Ceusses avant")
  //  crée l'ensemble des résultats de recherche
ZListe:=False:C215  //  initialise le booléen de saisie en liste
ZAjoutEnr:=False:C215  //  initialise le booléen d'ajout
DiaZCréerMaFenêtre 
DiaFenetreActualiseTitre 
  //Si ((<>PermLecteur) & (ZToutNeuf)) | (Non(ZToutNeuf) & (ZModif)) | (<>Boss)
READ WRITE:C146(ZPtTable->)
  //Sinon
  //LECTURE SEULEMENT(ZPtTable->)
  //Fin de si

CREATE EMPTY SET:C140(ZPtTable->;"UserSet")
CREATE EMPTY SET:C140(ZPtTable->;"LockedSet")

If (Count parameters:C259>1)  //  loock cgm
	ZNomForImpLis:=$3
	ZNomForImpFic:=$6
	ZBoumProc:=$8
	ZNomForAffLis:=$2
	ZNomForEntVis:=$4
	ZNomForAffSai:=$5
	FORM SET OUTPUT:C54(ZPtTable->;$2)
	FORM SET INPUT:C55(ZPtTable->;$5)
	
	Repeat 
		If ((ZListe) & ($6#""))  // modification en liste
			FORM SET INPUT:C55([DiaData:45];$6)  // le format d'accueil doit être dans [XDonnées]
			ADD RECORD:C56([DiaData:45];*)
		Else 
			If (<>PermLecteur)
				MODIFY SELECTION:C204(ZPtTable->;*)  //permet par double-clic de modifier la fiche
			Else 
				DISPLAY SELECTION:C59(ZPtTable->;*)  //permet par double-clic de visualiser la fiche
			End if 
		End if 
	Until (ZFini)
Else   //  look casa
	ZNomForImpLis:="ListImp"
	ZNomForImpFic:="FichImp"
	ZNomForAffLis:="Liste"
	ZNomForAffSai:="Saisie"
	ZNomForEntVis:="ListeVisu"
	FORM SET OUTPUT:C54(ZPtTable->;"Liste")
	FORM SET INPUT:C55(ZPtTable->;"Saisie")
	If (ZModif)
		MODIFY SELECTION:C204(ZPtTable->;*)  //permet par double-clic de modifier la fiche
	Else 
		DISPLAY SELECTION:C59(ZPtTable->;*)  //permet par double-clic de visualiser la fiche
	End if 
End if 
CLOSE WINDOW:C154
READ ONLY:C145(ZPtTable->)
UNLOAD RECORD:C212(ZPtTable->)
ZListe:=False:C215
ZFini:=False:C215
SET MENU BAR:C67(1)