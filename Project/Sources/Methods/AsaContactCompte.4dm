//%attributes = {"lang":"fr"}
// ---------------------------------------------------[XData]XValeur-
// Nom utilisateur (OS) : asa-spv
// Date et heure : 06/05/14, 09:04:48
// ----------------------------------------------------
// Méthode : AsaContactCompte
// Description
// Décompte le nombre de téléchargement d'AsaDia
//
// Paramètre {$1} si existe incrémente ce nombre
// ----------------------------------------------------
$Mess:=""
QUERY:C277([XData:1]; [XData:1]XType:3="ACo")
SELECTION TO ARRAY:C260([XData:1]XValeur:7; $TbNum; [XData:1]XEntier:6; $TbTot)
If (Size of array:C274($TbNum)>0)
	SORT ARRAY:C229($TbNum; $TbTot; <)
	$s:=Num:C11($TbTot{1}>1)*"s"
	$Mess:="Nombre d'ASAContact"+$s+" "+String:C10($TbNum{1})+" téléchargé"+$s+" sur le Web : "+String:C10($TbTot{1})
Else 
	$Mess:="Pas d'ASAContact téléchargé sur le Web"
End if 
$0:=$Mess