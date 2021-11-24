//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : ASA
// Date et heure : 08/06/21, 14:38:57
// ----------------------------------------------------
// Méthode : ASAPFacTrouveDateRèglement
// Description
// Méthode qui permet d'obtenir la date de règlement
// 30 jours fin de mois.
// Paramètres
// $1 = Date de règlement
// ----------------------------------------------------

$Date:=$1
$Date1:=Add to date:C393($Date; 0; 0; 30)
$MoisRèglement:=Month of:C24($Date1)
Case of 
	: ($MoisRèglement=1)
		$MoisPlus1:=2
		$Année:=Year of:C25($Date)+1
		
	: ($MoisRèglement=12)
		$MoisPlus1:=1
		$Année:=Year of:C25($Date)+1
		
	Else 
		$MoisPlus1:=$MoisRèglement+1
		$Année:=Year of:C25($Date)
End case 
$Date2:=Date:C102("01/"+String:C10($MoisPlus1)+"/"+String:C10($Année))
$DateRèglement:=Add to date:C393($Date2; 0; 0; -1)
$0:=$DateRèglement