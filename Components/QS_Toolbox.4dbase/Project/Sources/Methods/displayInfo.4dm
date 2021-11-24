//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 11/10/17, 09:53:49
  // ----------------------------------------------------
  // Méthode : DisplayInfo
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------
  // cannot be treadsafe due to OBJECT Get pointer


C_TEXT:C284($1;$start;$EndTag)
C_OBJECT:C1216($QS_data)

$QS_data:=Storage:C1525.QS_TBX_SHARED_DATA
$EndTag:=$QS_data.QS_TBX_END_TAG

If (Count parameters:C259=2)
	C_TEXT:C284($2)
	$color:=$2
Else 
	$color:="blue"
End if 

Case of 
	: ($color="red")
		$color:=$QS_data.QS_TBX_COLOR_RED
		
	: ($color="blue")
		$color:=$QS_data.QS_TBX_COLOR_BLUE
		
	: ($color="green")
		$color:=$QS_data.QS_TBX_COLOR_GREEN
		
End case 

$start:=HTP_Util_GiveStyleTag ($color;"";"")
$ptr:=OBJECT Get pointer:C1124(Object named:K67:5;"FenetreInformation")
If ($ptr#Null:C1517)
	$ptr->:=$start+$1+$EndTag
End if 
