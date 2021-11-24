//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 18/04/20, 18:49:54
// ----------------------------------------------------
// Méthode : DeplaceFlecheLesionWeb
// Description
// Méthode qui déplace les flèches indicatrices
//  pour le dialogue Antichambre 2
// Paramètre : $1 = type de flèches
//  0=à droite 1=en bas 2=à gauche 3=en bas
// ----------------------------------------------------

$DébutNomFleche:=String:C10($1+1)  // choix de l'image radio (type de fleche)
$T:=False:C215
$NomFleche:=$DébutNomFleche+"1"
OBJECT GET COORDINATES:C663(VarImageV; $G; $H; $D; $B)
GET MOUSE:C468(sourisX; sourisY; boutonSouris)
XClic:=sourisX
YClic:=-sourisY
Xa:=XClic
Ya:=YClic
Xr:=XClic-$G
Yr:=YClic+$H
Xp:=Xr/($D-$G)
Yp:=Yr/($B-$H)
$NomChamp:="C"+$NomFleche
$NomBouton:="B"+$NomFleche
OBJECT GET COORDINATES:C663(*; $NomFleche; Fgauche; Fhaut; Fdroite; Fbas)
Case of 
	: ($1=0)  // fleche à droite
		YBF:=-(Fhaut+((Fbas-Fhaut)/2))
		XBF:=Fdroite
		YBC:=YBF
		XBC:=XBF-(FDroite-FGauche)
		
	: ($1=1)  // fleche en bas
		YBF:=-Fbas
		XBF:=(Fgauche+((Fdroite-Fgauche)/2))
		YBC:=-Fhaut
		XBC:=XBF+(Fdroite-Fgauche)
		
	: ($1=2)  // fleche à gauche
		YBF:=-(Fhaut+((Fbas-Fhaut)/2))
		XBF:=Fgauche
		YBC:=YBF
		XBC:=XBF+(FGauche-FDroite)
		
	: ($1=3)  // fleche en haut
		YBF:=-Fhaut
		XBF:=(Fgauche+((Fdroite-Fgauche)/2))
		YBC:=YBF-(Fbas-Fhaut)
		XBC:=XBF
End case 
XDep:=XClic-XBF
YDep:=YBF-YClic
OBJECT MOVE:C664(*; $NomFleche; XDep; YDep)
OBJECT MOVE:C664(*; $NomChamp; XDep; YDep)
OBJECT MOVE:C664(*; $NomBouton; XDep; YDep)
OBJECT SET ENTERABLE:C238(*; $NomChamp; True:C214)
$Pt:=Get pointer:C304("Var"+$NomChamp)
If ($Pt->="")
	OBJECT SET FONT SIZE:C165(*; $NomChamp; 10)
End if 
// ALLER À OBJET(*;$NomChamp)
DiaStockeLesFleches