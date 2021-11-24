//%attributes = {"invisible":true,"executedOnServer":true,"preemptive":"capable","publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false}
// ----------------------------------------------------
// Méthode : QST_licence
// Description
// 
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 27/07/19, 07:50:26
// Paramètres

C_TEXT:C284($licenceFolder; $licenceText)
C_OBJECT:C1216($licence)
C_DATE:C307($endEvaluationDate; $extractDateFromKey)
C_TEXT:C284($QS_VCS_COMP_DB_PATH; $lic_name)
C_BLOB:C604($blob; $blob2)
C_OBJECT:C1216($0; $result)

$result:=New object:C1471("result"; True:C214; "title"; ""; "wizard"; False:C215)
SET BLOB SIZE:C606($blob; 0)
SET BLOB SIZE:C606($blob2; 0)

$QS_VCS_COMP_DB_PATH:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_ExternalDB
$licence:=New object:C1471
$file:=Folder:C1567(fk licenses folder:K87:16).file("qs_toolbox.licence")

If ($file.exists)
	// The componant has already been used on this machine
	// Check if the licence file has been modified manually
	$licenceText:=$file.getText("UTF-8")
	$licence:=JSON Parse:C1218($licenceText)
	
	If (key_checkKey($licence))
		$testKey:=key_createKey($licence)
		$extractDateFromKey:=key_getExpirationDate($licence)
		
		Case of 
			: ($extractDateFromKey#Date:C102($licence.end))
				$result.result:=False:C215
				$result.title:="touched"
				
			: (Date:C102($licence.end)<Current date:C33) & ($licence.demo=False:C215)  // End of the licence
				$licence.renew:=True:C214
				$licenceText:=JSON Stringify:C1217($licence)
				TEXT TO DOCUMENT:C1237($fileName; $licenceText)
				
		End case 
		
	Else   // Struture of $licence.key is not correct anymore. Someone touched it
		$result.result:=False:C215
		$result.title:="touched"
		
	End if 
	$result.licence:=$licence
	
Else 
	// This is the first time
	// So, first, get the current date to determine end of "evaluation time"
	$endEvaluationDate:=Add to date:C393(Current date:C33; 0; 0; 60)  // 60 days
	
	$licence.name:="no licence"
	$licence.email:=""
	$licence.company:=""
	$licence.end:=String:C10($endEvaluationDate)
	$licence.server:=True:C214  // testing must be able on a server
	$licence.demo:=True:C214
	$licence.renew:=False:C215
	$licence.key:=key_createKey($licence)
	
	key_create1stTime($licence)
	$result.licence:=$licence
	
End if 

If ($licence.renew=True:C214) | ($licence.demo=True:C214)
	$result.wizard:=True:C214
End if 

$result.result:=(Current date:C33<=Date:C102($licence.end))
$0:=$result