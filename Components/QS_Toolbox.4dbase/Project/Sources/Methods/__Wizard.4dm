//%attributes = {"invisible":true,"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_LONGINT:C283($ref)
C_OBJECT:C1216($licenceOldValues;$licence)
C_TEXT:C284($oldLicenceKey)
C_DATE:C307($start;$endEvaluationDate;$dateFromKey)

$licence:=New object:C1471
$licenceOldValues:=New object:C1471
$licence:=OB Copy:C1225(Storage:C1525.licence.licence)  // shared object -> object (see OB copy documentation)
$licenceOldValues:=OB Copy:C1225(Storage:C1525.licence.licence)

If ($licence.demo)
	$oldLicenceKey:=$licence.key
	$licence.key:=""
End if 

$ref:=Open form window:C675("_WIZARD";Palette form window:K39:9;Horizontally centered:K39:1;Vertically centered:K39:4)
DIALOG:C40("_WIZARD";$licence)
CLOSE WINDOW:C154

If ($licence.key="")
	$licence.key:=$oldLicenceKey
End if 

$dateFromKey:=key_getExpirationDate ($licence)

Case of 
	: ($dateFromKey>=Current date:C33)
		  // does a new licence enter?
		If ($dateFromKey>Date:C102($licence.end))
			$licence.end:=String:C10($dateFromKey)
			$licence.demo:=False:C215
			$licence.renew:=False:C215
			ALERT:C41("Your licence is valid until: "+String:C10($dateFromKey;Internal date long:K1:5))
		End if 
		
	: ($licence.renew=True:C214) & ($dateFromKey<Current date:C33)
		  // We will let him/her a 15 days more. Just time for him to get a new licence
		$start:=Date:C102("01/"+String:C10(Month of:C24(Current date:C33))+"/"+String:C10(Year of:C25(Current date:C33)))
		$endEvaluationDate:=Add to date:C393($start;0;0;14)  // 2 weeks from today
		$licence.key:=key_createKey ($licence)
		$licence.end:=String:C10($endEvaluationDate)
		$licence.demo:=True:C214
		$licence.renew:=False:C215
		ALERT:C41("Your licence expired on "+String:C10(Date:C102($dateFromKey))+". You still have 2 weeks delay from this to get a new valid licence number.")
		
	: ($licence.renew=False:C215) & ($dateFromKey<Current date:C33)
		  // Licence is really expired
		ALERT:C41("Your licence expired. QS_Toolbox will not start anymore.")
		
End case 

$new:=JSON Stringify:C1217($licence)
$old:=JSON Stringify:C1217($licenceOldValues)

If ($new#$old)
	key_update ($licence)
	$o:=New object:C1471("licence";$licence)
	key_toStorage ($o)
End if 
