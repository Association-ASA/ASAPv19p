//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// ----------------------------------------------------
// nom utilisateur (OS) : Association QualiSoft
// date et heure : 21/09/14, 20:39:49
// ----------------------------------------------------
// méthode : Base_GetPoliceStyle
// description
//
//
// paramètres
// ----------------------------------------------------

#DECLARE($TypeNum : Integer)->$description : Text

$description:="Normal"
Case of 
		
	: ($TypeNum=1)
		$description:="Bold"
		
	: ($TypeNum=2)
		$description:="Italic"
		
	: ($TypeNum=3)
		$description:="Bold-Italic"
		
	: ($TypeNum=4)
		$description:="Underline"
		
	: ($TypeNum=5)
		$description:="Bold-Underline"
		
	: ($TypeNum=6)
		$description:="Italic-Underline"
		
	: ($TypeNum=7)
		$description:="Bold-Italic-Underline"
		
End case 