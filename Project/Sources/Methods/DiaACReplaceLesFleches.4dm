//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 19/04/20, 07:16:26
  // ----------------------------------------------------
  // Méthode : AntichambreReplaceLesFleches
  // Description
  // Méthode qui replace les fleches hors du champ
  // Paramètres : aucun
  // ----------------------------------------------------

For ($salé;1;4)
	$NomFleche:=String:C10($salé)+"1"
	$NomChamp:="C"+$NomFleche
	$Pt:=Get pointer:C304("Var"+$NomChamp)
	If ($Pt->#"")
		Xdep:=5700
		Ydep:=-5700
		OBJECT MOVE:C664(*;$NomFleche;XDep;YDep)
		OBJECT MOVE:C664(*;$NomChamp;XDep;YDep)
	Else 
		OBJECT MOVE:C664(*;$NomFleche;5700;-7500)
		OBJECT MOVE:C664(*;$NomChamp;5700;-7500)
	End if 
End for 
LesFlechesSontLà:=False:C215
OBJECT SET TITLE:C194(BouPlaceF;"Placer les explications")
CaseSaisie:=0