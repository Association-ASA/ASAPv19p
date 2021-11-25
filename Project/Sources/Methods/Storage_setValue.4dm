//%attributes = {}
/* ----------------------------------------------------
 Méthode : Storage_setValue
 ----------------------------------------------------
 Paramètres
 $1 = Attribut à creer dans le Storage (Texte)
 $2 = Valeur à Stocker (variant: bool, text, collection, object)
 {$3} = nom de l'objet dans lequel il faut déposer la valeur à stocker
 ----------------------------------------------------
 Nom utilisateur (OS) : Association QualiSoft
 Date et heure : 31/10/19, 11:22:48
 Description
 Stocke des information dans Storage de manière à pouvoir les rappeler par après,
 Update QualiSoft - Patrick EMANUEL, 02/03/21 - 08:08:21
 Revue et corrigé avec Variant afin de simplifer le code et réduire le nombre de méthodes

*/

var $1 : Text  // Storage.xxx
var $2 : Variant  // true/False or Object, Collection, text ....
var $Parameter : Object

If (Count parameters:C259=3)
	var $3 : Text
	If ($3="*")
		$Parameter:=Storage:C1525["shared"]
	Else 
		$Parameter:=Storage:C1525[$3]
		If ($Parameter=Null:C1517)
			Use (Storage:C1525)
				Storage:C1525[$3]:=New shared object:C1526
			End use 
			$Parameter:=Storage:C1525[$3]
		End if 
	End if 
Else 
	$Parameter:=Storage:C1525
End if 

Use (Storage:C1525)
	Use ($Parameter)
		$Parameter[$1]:=$2
	End use 
End use 
