//%attributes = {"invisible":true,"shared":true,"preemptive":"capable","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"publishedWeb":false,"publishedSoap":false,"published4DMobile":{"scope":"none"}}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 13/11/17, 08:36:14
// ----------------------------------------------------
// Méthode : PIC_GetPicture
// Description
// Retreive picture from the local Resources folder
//
// Paramètres
// ----------------------------------------------------

// #DECLARE($path : Text)->$img : Picture

C_TEXT:C284($1; $path)
C_PICTURE:C286($0; $img)

ASSERT:C1129(Count parameters:C259=1; "1 parameter expected")
ASSERT:C1129(Type:C295($1)=Is text:K8:3; "$1 must be path like img/name.png")

$path:=$1
//READ PICTURE FILE(File("/RESOURCES/"+$path).platformPath; $Img)
READ PICTURE FILE:C678(Folder:C1567(fk resources folder:K87:11).file($path).platformPath; $Img)
$0:=$img