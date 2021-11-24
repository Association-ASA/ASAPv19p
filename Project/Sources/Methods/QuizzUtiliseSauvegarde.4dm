//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 31/05/20, 06:39:57
// ----------------------------------------------------
// Méthode : QuizzUtiliseSauvegarde
// Description
// Méthode qui restitue un questionnaire
//  à partir d'une sauvegarde
// Paramètre : $1=message AJAX 
// type bouhistoire + N° d'enregistrement de la [XDonnees]
// ----------------------------------------------------
$Mess:=$1
$NumEnr:=Num:C11($1)
If ($Mess="@&")
	QuizzEcritHTMLBodyQuestionnaire($NumEnr)
Else 
	GOTO RECORD:C242([DiaData:45]; $NumEnr)
	If ($Mess#"@_")  // sinon il a demandé à conserver le questionnaire en état
		QuizzRecup1questionnaire(String:C10([DiaData:45]XEntier:2); True:C214)
	End if 
	QuizzEcritHTMLBodyQuestionnaire([DiaData:45]XEntier:2)
End if 