//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 27/01/19, 15:00:06
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ZMOBouPartenaire
  // Description
  // méthode qui permet la gestion srandard des adhérents
  // à titre personnel

ARRAY TEXT:C222(TbMethodeLapin;0)
C_OBJECT:C1216($ObParam)
C_TEXT:C284($Chemin)

If (Macintosh command down:C546)
	QUERY:C277([Personnes:12];[Personnes:12]TypePersonne:5="Testeur")
	$MéthodeAvant:="ASAPSurChargementSaisiePartenaire"
Else 
	QUERY:C277([Personnes:12];[Personnes:12]TypePersonne:5="Partenaire";*)
	QUERY:C277([Personnes:12]; & [Personnes:12]Caduc:8=False:C215)
	$MéthodeAvant:="ASAPSurChargementSaisiePartner"
End if 
$Chemin:="Images/Buttons/BouPartenaire.png"
$CDImage:=Get 4D folder:C485(Dossier Resources courant:K5:16)+Replace string:C233($Chemin;"/";Séparateur dossier:K24:12)
$MethodesLapîn:="Envoyer un courriel:ASAPEnvoiCourrielLabo"\

VarModifPer:=False:C215
VarModifPar:=False:C215


OB SET:C1220($ObParam\
;"Champ significatif";->[Personnes:12]NomLong:2\
;"Champ clefs";->[Personnes:12]ChampRecherche:6\
;"Chemin logo";$CDImage\
;"Saisie";"SaisiePartenaire"\
;"Sortie";"Liste"\
;"Fiche";"Fiche"\
;"Avant";$MéthodeAvant\
;"Après";"ASAPSurValidationSaisiePartenai"\
;"Sur destruction";"ZBoumAdh"\
;"Gestion ensemble";True:C214\
;"Méthode lapin";$MethodesLapîn\
;"Dialogue";"LBTableauxPerso"\
;"Méthode qui remplit les tableaux";"ASAPPerFabriqueTb"\
;"Gestion tableaux";True:C214)
ZLBGèreListe ($ObParam)
