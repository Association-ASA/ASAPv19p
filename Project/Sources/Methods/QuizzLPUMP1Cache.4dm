//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 13/09/21, 10:46:55
// ----------------------------------------------------
// Méthode : QuizzLPUMP1Cache
// Description
// Méthode qui renvoir la liste des photos
//  en cachant les lignes non pertinentes
// Paramètres: $1=message AJAX type LPUMEspece_Bovins_Abattoir
// ----------------------------------------------------
$Mess:=$1
ARRAY TEXT:C222($Tb; 0)
ZTexteVersTableau($Mess; ->$Tb; "_")
$Type:=$Tb{1}
$Valeur:=$Tb{2}
$Origine:=$Tb{3}

QUERY:C277([DiaData:45]; [DiaData:45]XType:5="quizzphoto"; *)
QUERY:C277([DiaData:45]; [DiaData:45]XAlpha:14=$Origine; *)
QUERY:C277([DiaData:45];  & [DiaData:45]XBool:9=False:C215)
DISTINCT VALUES:C339([DiaData:45]XTexte:7; TbPUMListeEspece)
DISTINCT VALUES:C339([DiaData:45]XTexteSup:8; TbPUMListeLesion)
If ($Valeur#"Toutes les @")
	If ($Tb{1}="LiPUMEspece")
		QUERY SELECTION:C341([DiaData:45];  & [DiaData:45]XTexte:7=$Valeur)
	Else 
		QUERY SELECTION:C341([DiaData:45];  & [DiaData:45]XTexteSup:8=$Valeur)
	End if 
End if 

$HTML:=QuizzListePhotosQuizz($Origine; $Valeur; $Type)
WEB SEND TEXT:C677($HTML)