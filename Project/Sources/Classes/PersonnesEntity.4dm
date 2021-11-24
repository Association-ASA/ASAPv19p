Class extends Entity


//This.Arguments:=New object
//This.Arguments.emailRAEMA:=""


Function recupAdresse($type : Text)->$result : Text
/*
$Type : Critère principal de recherche de l'adresse
{$type2} = $2: Critère secondaire pris en compte en cas d'absence d'adresse avec le critère principal
*/
	var $e : Object
	
	$e:=This:C1470.PersonnesAdresses_Personnes.query("TypeAdresse =:1"; $type).first()
	
	If ($e=Null:C1517)
		If (Count parameters:C259=2)
			$type:=$2
			$e:=This:C1470.PersonnesAdresses_Personnes.query("TypeAdresse =:1"; $type).first()
			
			If ($e=Null:C1517)
				$result:=""
				
			Else 
				$result:=$e.CodePostal+" "+$e.Pays
			End if 
			
		Else 
			$result:=""
		End if 
		
	Else 
		$result:=$e.CodePostal+" "+$e.Pays
	End if 
	
	
Function recupMail($type : Text)->$mail : Text
	$mail:="---------------"
	
	If (This:C1470.Arguments#Null:C1517)
		If (OB Get:C1224(This:C1470.Arguments; $type; Is text:K8:3)#"")
			$mail:=This:C1470.Arguments[$type]
		End if 
	End if 
	
	