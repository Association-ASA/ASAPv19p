//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Méthode : STO_TraiteChaine
// ----------------------------------------------------
// Paramètres
// $1 = Nom de la propriété de Form à traiter
// {$2} = Passe toute la chaine en majuscule
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 08/07/18, 10:49:09
// Description
//

C_TEXT:C284($1)
If (Form:C1466[$1]#Null:C1517)
	Form:C1466[$1]:=ZCapitalizeString(Form:C1466[$1]; 15)
	
	If (Count parameters:C259=2)
		Form:C1466[$1]:=Uppercase:C13(Form:C1466[$1])
	End if 
End if 