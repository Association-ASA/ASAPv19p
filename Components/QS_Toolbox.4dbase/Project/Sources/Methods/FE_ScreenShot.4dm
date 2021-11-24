//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 05/03/19, 15:17:50
  // ----------------------------------------------------
  // Méthode : FORMS_ScreenShot
  // Description
  // $1 : longint -> table num or 0 for project 
  // $2 : text -> form Name
  // Paramètres
  // ----------------------------------------------------

C_PICTURE:C286($FormImage)
C_LONGINT:C283($FormThePage;$tableNum;$1;$3)
C_TEXT:C284($formName;$2)

$tableNum:=$1
$formName:=$2
$FormThePage:=1
If (Count parameters:C259=3)
	$FormThePage:=$3
End if 

C_OBJECT:C1216($param)
$param:=New object:C1471("pageNum";$FormThePage;"table";$tableNum;"project";Bool:C1537($tableNum=0);"formName";$formName)
$FormImage:=TOOL_getScreenShot ($param)

  // Update the size to the web area size
If ($tableNum>0)
	$name:=Table name:C256($tableNum)
Else 
	$name:="projectform"
End if 
  //$path:=Storage.QS_TBX_SHARED_DATA.QS_TBX_DestinationPath+"Forms"+Folder separator
$picturePath:=Temporary folder:C486+$name+"-"+$formName+"-"+String:C10($FormThePage)+".jpg"

If (Test path name:C476($picturePath)=Is a document:K24:1)
	DELETE DOCUMENT:C159($picturePath)
End if 

OBJECT GET COORDINATES:C663(*;"webZone";$g;$h;$d;$b)
PICTURE PROPERTIES:C457($FormImage;$largeur;$height)
If (($d-$g)<$largeur)
	$factor:=($d-$g)/$largeur
	TRANSFORM PICTURE:C988($FormImage;Scale:K61:2;$factor;$factor)
End if 

If (Picture size:C356($FormImage)>0)
	WRITE PICTURE FILE:C680($picturePath;$FormImage;".jpg")
	$picturePath:=Convert path system to POSIX:C1106($picturePath)  // -- For Mac comptability
	WA OPEN URL:C1020(*;"webZone";"file:///"+$picturePath)
Else 
	UTIL_noPicturePath 
End if 