//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // nom utilisateur (OS) : Association QualiSoft
  // date et heure : 21/09/14, 20:28:03
  // ----------------------------------------------------
  // méthode : Base_ObjectGetBordureType
  // description
  //
  //
  // paramètres
  // ----------------------------------------------------

C_TEXT:C284($0;$description)
C_LONGINT:C283($TypeNum;$1)

  // _
$TypeNum:=$1
$description:="None"

Case of 
		
	: ($TypeNum=1)
		$description:="Continuous 1-pt. border line"  // normal
		
	: ($TypeNum=2)
		$description:="Dotted 1-pt. border line"  // pointillé 1pt
		
	: ($TypeNum=3)
		$description:="3D effect (raised)"  // effet 3D
		
	: ($TypeNum=4)
		$description:="Sunken 3D effect"  // "Relief inversé"
		
	: ($TypeNum=5)
		$description:="Double line (separated by a pixel)"  // "Double"
		
	: ($TypeNum=6)
		$description:="Line drawn based on the graphic specifications of the system"  // "Système"
		
End case 

$0:=$description
