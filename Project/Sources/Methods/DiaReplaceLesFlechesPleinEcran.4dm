//%attributes = {}
  // ReplaceLesFlechesPleinEcran
For ($salé;1;4)
	$NomFleche:=String:C10($salé)+"1"
	$NomChamp:="C"+$NomFleche
	$Pt:=Get pointer:C304("Var"+$NomChamp)
	If ($Pt->#"")
		Xdep:=5700
		Ydep:=-5700
		OBJECT MOVE:C664(*;$NomFleche;XDep;YDep)
		OBJECT MOVE:C664(*;$NomChamp;XDep;YDep)
		OBJECT SET ENTERABLE:C238($Pt->;False:C215)
	Else 
		OBJECT MOVE:C664(*;$NomFleche;5700;-7500)
		OBJECT MOVE:C664(*;$NomChamp;5700;-7500)
	End if 
End for 
LesFlechesSontLà:=False:C215
OBJECT SET TITLE:C194(BouPlaceF;"Placer les explications")
CaseSaisie:=0