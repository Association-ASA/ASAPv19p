//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"lang":"en"}
// ----------------------------------------------------
// nom utilisateur (OS) : Association QualiSoft
// date et heure : 04/02/17, 11:50:09
// ----------------------------------------------------
// méthode : DATE_ConvertAsText
// description
//
// paramètres
// ----------------------------------------------------
// DATE_ConvertAsText (date ; {-} ; {heure} ) -> "AAAA-MM-JJ" ou "AAAAMMJJ" ou "2010030311:40:12422"

// CONVERTIT LA DATE $1 EN CHAÎNE DE TYPE "2003-05-23"
// $2= {caractère séparateur optionnel, aucun par défaut}
// ecrit à Noboribetsu le 23 juin 2003

C_DATE:C307($1; $Date)
C_TIME:C306($3)
C_TEXT:C284($2; $Separateur; $heure)
C_TEXT:C284($0)

$Date:=$1

If (Count parameters:C259>=2)
	$Separateur:=$2
Else 
	$Separateur:=""
End if 

If (Count parameters:C259>=3)  // on a donné l'heure
	$heure:=Time string:C180($3)+String:C10(Milliseconds:C459%1000; "000")
Else 
	$heure:=""
End if 

$0:=String:C10(Year of:C25($Date); "0000")+$Separateur+String:C10(Month of:C24($Date); "00")+$Separateur+String:C10(Day of:C23($Date); "00")+$heure
